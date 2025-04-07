//The Job of the ShipMaster is to hold all statuses of each object
global.debug = true

lastPosX = posx
lastPosY = posy


forward = {x:lengthdir_x(1,self.angle),y:lengthdir_y(1,self.angle)}

movementQueue = ds_queue_create()

avtUpdateRate = 0.1
artUpdateRate = 1



avgVelocityTimer = 0
avgVelocityAmt = 1
avgVelocityHistory = array_create(avgVelocityAmt,0)


avgRotationTimer = 0
avgRotationAmt = 5
avgRotationHistory = array_create(avgRotationAmt,0)


#region Navigation Parameters
forwardForces = array_create(0)
rotationForces = array_create(0)

forwardPct = 0
forwardV = 0
forwardA = 0
forwardFrict = 0.85
maxForwardV = 1

rotationPct = 0
minRotV = 0.1
rotationV = 0
rotationA = 0
rotationFrict = 0.05
maxRotationV = 1
#endregion








isNavvingPath = false
pathNavCurr = 0
pathDist = 0
pathNavSpeed = 100

pathCDF = 0


function register_force(force, isRot=false){
	if isRot
		array_insert(rotationForces,0,force)
	else 
		array_insert(forwardForces,0,force)
}



function setMovement(newForward=forwardV,newRotation=rotationV) {
	forwardV = newForward
	rotationV = newRotation
}

function offsetMovement(newForward=0,newRotation=0) {
	forwardV += newForward
	rotationV += newRotation
	
	forwardV = min(forwardV,maxForwardV)
	rotationV = min(rotationV,maxRotationV)
}

function navToPoint(targetX,targetY) {

	var angleDiff = angle_difference(ShipMaster.angle , point_direction(ShipMaster.posx,ShipMaster.posy,targetX,targetY))
	//var angleDiff = angle_difference(ShipMaster.angle , point_direction(target.x,target.y,target2.x,target2.y))
	var distToTarget = point_distance(ShipMaster.posx,ShipMaster.posy,targetX,targetY)

	
	var time2Pos = distToTarget/maxForwardV
	var time2Rot = abs(angleDiff)/maxRotationV
	
	var scaler = max(time2Pos,time2Rot)
	

	setMovement(distToTarget/scaler, angleDiff/scaler*sign(angleDiff)*-1)
	
	return distToTarget
	
}
	
function navPath(){
	var target = ControllerService.shipStatus.map.navPath[0]
	var target2 = ControllerService.shipStatus.map.navPath[1]
	ShipMaster.queueMovement(ShipMaster.orientToPoint,[target.x,target.y], 0,10)
	ShipMaster.queueMovement(ShipMaster.navToPoint,[target.x,target.y], 0,20)
	ShipMaster.queueMovement(ShipMaster.orientToPoint,[target2.x,target2.y], 0,10,ShipMaster.navPathFixed)
	
	
}

function navPathFixed(){
	isNavvingPath = true
	pathNavCurr = 0
	pathCDF = curvatureCDF(ControllerService.shipStatus.map.navPath,true)

}

function stopNavPath(success){
	isNavvingPath = false
	pathNavCurr = 0
	ControllerService.shipStatus.map.navPath = array_create(0)
	ControllerService.shipStatus.map.stateMachine.changeState("scanOut")
}

//Smooths a point path
function chaikin(pointArray) {
	var newPath = array_create(0)
	
	for (var i = 0; i < array_length(pointArray)-1;i++){
		var p0 = pointArray[i]
		var p1 = pointArray[i+1]
		
		var Qx = 0.75 * p0.x + 0.25 * p1.x
		var Qy = 0.75 * p0.y + 0.25 * p1.y
		
		var Rx = 0.25 * p0.x + 0.75 * p1.x
		var Ry = 0.25 * p0.y + 0.75 * p1.y
		
		var q = {x:Qx,y:Qy}
		var r = {x:Rx,y:Ry}
		array_push(newPath,q,r)
	}
	
	return newPath
		
}

function mengerCurvature(p0,p1,p2){
	var a10 = point_direction(p1.x,p1.y,p0.x,p0.y)
	var a12 = point_direction(p1.x,p1.y,p2.x,p2.y)
	
	var angle = abs(angle_difference(a10,a12))
	
	var triangleArea = (p1.x-p0.x)*(p2.y-p1.y) - (p1.y-p0.y)*(p2.x-p1.x)
	
	var d01 = point_distance(p0.x,p0.y,p1.x,p1.y)
	var d12 = point_distance(p1.x,p1.y,p2.x,p2.y)
	var d20 = point_distance(p2.x,p2.y,p0.x,p0.y)
	
	var curve = 4*triangleArea/(d01*d12*d20)
	
	return curve
	
}

function curvatureCDF(pointArray,normalize) {
	var largestCurve = -1
	var curvature = array_create(0)
	
	for (var i = 1; i < array_length(pointArray)-1; i++) {
		//print(i)
		
		var p0 = pointArray[i-1]
		var p1 = pointArray[i]
		var p2 = pointArray[i+1]
		
		
		
		
		
		var curve = mengerCurvature(p0,p1,p2)
		if curve > largestCurve
			largestCurve = curve
			
		array_push(curvature,curve)
		
		
	}	
	if normalize
		for (var i = 0; i < array_length(curvature); i++){
			curvature[i] = curvature[i]/largestCurve
		}
	
	array_insert(curvature,0,curvature[0])
	array_push(curvature,array_last(curvature))
	return curvature
	
}

function anglePrune(pointArray,angleToTrim){
	var curvature = curvatureCDF(pointArray)
	var heartbeatGoal = 0.013
	
	//Create curvature CDF
	
	var newPath = array_create(1, pointArray[0])

	var heartbeat = 0
	
	for (var i = 0; i < array_length(pointArray); i++) {
		
		var currNode = pointArray[i]
		var currCurve = curvature[i]
		
		heartbeat += abs(currCurve)
		

		
		if heartbeat > heartbeatGoal {

			heartbeat %= heartbeatGoal
			array_push(newPath, pointArray[i])
		}
	}
	
	
	
	return newPath
}
//Works fine now, but should be updated later
//New version needs this: Pass one, smoothing. Pass two, angle based pointing.
//The new Pass 2 should also traverse the lines itself, not the nodes
function pruneNavPath(){
	print("Pre-Prune Count: ", array_length(ControllerService.shipStatus.map.navPath))
	pathDist = 0
	

	//ControllerService.shipStatus.map.navPath = chaikin(ControllerService.shipStatus.map.navPath)
	ControllerService.shipStatus.map.navPath = chaikin(ControllerService.shipStatus.map.navPath)
	//ControllerService.shipStatus.map.navPath = anglePrune(ControllerService.shipStatus.map.navPath,5)	

	
	//Calculate Path Distance
	for (var i = 0; i < array_length(ControllerService.shipStatus.map.navPath)-1; i++) {
		
		var currentPoint = ControllerService.shipStatus.map.navPath[i]
		var nextPoint = ControllerService.shipStatus.map.navPath[i+1]
		
		pathDist += point_distance(currentPoint.x,currentPoint.y,nextPoint.x,nextPoint.y)
		
	}
	
	
	print("Post-Prune Count: ", array_length(ControllerService.shipStatus.map.navPath))
		
		
		


	
}



function orientToPoint(targetX,targetY){
	
	
	
	var currDiff = angle_difference(ShipMaster.angle , point_direction(ShipMaster.posx,ShipMaster.posy,targetX,targetY))
	
	setMovement(,1)
	
	return currDiff
}
	
function queueMovement(movementFunc,args,exitValMin,exitValMax,finFunc=function(){}){
	ds_queue_enqueue(movementQueue,[movementFunc,args,exitValMin,exitValMax,finFunc])
}



randomize()

