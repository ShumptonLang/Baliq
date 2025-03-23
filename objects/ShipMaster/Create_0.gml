//The Job of the ShipMaster is to hold all statuses of each object
global.debug = true

lastPosX = posx
lastPosY = posy


forward = {x:lengthdir_x(1,self.angle),y:lengthdir_y(1,self.angle)}

movementQueue = ds_queue_create()

avtUpdateRate = 1
artUpdateRate = 1

avgVelocityTimer = 0
avgVelocityAmt = 5
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

#region Map Buffer Creation

//Convert map into a surface
var surf = surface_create(8000,8000)//
surface_set_target(surf)
draw_sprite(spr_start,0,0,0)
surface_reset_target()


global.currMapBuffer = buffer_create(8000 * 8000*4, buffer_fast, 1);
buffer_get_surface(global.currMapBuffer, surf, 0);



surf = surface_create(256,256)//
surface_set_target(surf)
draw_sprite(funkyNoise,0,0,0)
surface_reset_target()


global.noiseBuffer = buffer_create(256 * 256*4, buffer_fast, 1);
buffer_get_surface(global.noiseBuffer, surf, 0);




#endregion

global.lidarSurf = surface_create(1000,1000)
global.sonarSurf = surface_create(camera_get_view_width(view_camera[0]),camera_get_view_height(view_camera[0]))

global.mapSurf = surface_create(4000,4000)

global.distSurf = surface_create(128,256)

surface_set_target(global.distSurf)
draw_clear(c_black)
surface_reset_target()

instance_create_depth(0,0,0,FMODManager)
instance_create_depth(0,0,-1000,oInputManager)
instance_create_depth(0,0,0,ControllerService)
instance_create_depth(0,0,0,AudioService)

//Can be either orient or path
isNavvingPath = false
pathNavCurr = 0
pathDist = 0
pathNavSpeed = 0.01
avgPathSpeed = 50
//Needs to move at 50/s
//framerate is 60/s

//TotalDist / 50 gives time of journey

//60*x= time
//time / 60?

//total dist / 50 / 60?


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
	//Need to get rid of the floating 50, it's the distance between points

}

function stopNavPath(success){
	isNavvingPath = false
	pathNavCurr = 0
	ControllerService.shipStatus.map.navPath = array_create(0)
	ControllerService.shipStatus.map.stateMachine.changeState("scanOut")
}



//Works fine now, but should be updated later
//New version needs this: Pass one, smoothing. Pass two, angle based pointing.
//The new Pass 2 should also traverse the lines itself, not the nodes
function pruneNavPath(){
	print("Pre-Prune Count: ", array_length(ControllerService.shipStatus.map.navPath))
	
	
	var pathNodeCount = array_length(ControllerService.shipStatus.map.navPath)
	
	var smallNavPath = array_create(0)
	array_insert(smallNavPath,0,ControllerService.shipStatus.map.navPath[0])
	for (var i = 1; i < pathNodeCount; i++) {
		
		var currentPoint = smallNavPath[0]
		var nextPoint = ControllerService.shipStatus.map.navPath[i]
		
		var nextDist = point_distance(currentPoint.x,currentPoint.y,nextPoint.x,nextPoint.y)
		if nextDist > 50 {
			

			array_insert(smallNavPath,0,nextPoint)
		}
	}
	
	//Prune Path
	pathNodeCount = array_length(smallNavPath)
	var equalNavPath = array_create(1,smallNavPath[0])
	array_insert(equalNavPath,0,smallNavPath[1])
	for (var i = 1; i < pathNodeCount; i++) {
		//if i % pruneRate == 0 {
		//	array_insert(equalNavPath,0,ControllerService.shipStatus.map.navPath[i])
		//	currentPoint = ControllerService.shipStatus.map.navPath[i]
		//}
		
		var currentPoint = equalNavPath[array_length(equalNavPath)-1]
		var nextPoint = smallNavPath[i]
		

		var prevPoint = equalNavPath[array_length(equalNavPath)-2]
			
		var nextAngle = point_direction(currentPoint.x,currentPoint.y,nextPoint.x,nextPoint.y)

		var comparisonAngle = point_direction(prevPoint.x,prevPoint.y,currentPoint.x,currentPoint.y)
			
		var angleVariance = angle_difference(nextAngle,comparisonAngle)

		//print(comparisonAngle,nextAngle,angleVariance)
			
		if abs(angleVariance) > 3 {
			
			print("Too far!! Rerouting")
				array_push(equalNavPath,smallNavPath[i])
		}
		
		
	}
	
	ControllerService.shipStatus.map.navPath = equalNavPath
	
	//Calculate Path Distance
	for (var i = 0; i < array_length(ControllerService.shipStatus.map.navPath)-1; i++) {
		
		var currentPoint = ControllerService.shipStatus.map.navPath[i]
		var nextPoint = ControllerService.shipStatus.map.navPath[i+1]
		
		pathDist += point_distance(currentPoint.x,currentPoint.y,nextPoint.x,nextPoint.y)
		
	}
	
	pathNavSpeed = avgPathSpeed / pathDist / 60
	
	print("Post-Prune Count: ", array_length(ControllerService.shipStatus.map.navPath))
		
		
		


	
}

//function orientToPoint(targetX,targetY,startingAngleDiff){
	
	
	
//	var currDiff = angle_difference(ShipMaster.angle , point_direction(ShipMaster.posx,ShipMaster.posy,targetX,targetY))
//	var pctComplete = currDiff/startingAngleDiff
//	var rotDir = -sign(currDiff)
//	var rotSpeed = 0
	
//	if pctComplete < 0.5 {
//		rotSpeed = smoothstep(0,1,pctComplete*2)*rotDir*maxRotationV
//	} 
//	else
//	{
//		rotSpeed = smoothstep(0,1,1-(pctComplete-0.5)*2)*rotDir*maxRotationV
//	}
	
//	rotSpeed = rotSpeed + minRotV*rotDir*abs(pctComplete*2-1)

	
//	setMovement(,rotSpeed)
	
//	return 1 - pctComplete
//}

function orientToPoint(targetX,targetY){
	
	
	
	var currDiff = angle_difference(ShipMaster.angle , point_direction(ShipMaster.posx,ShipMaster.posy,targetX,targetY))
	
	setMovement(,1)
	
	return currDiff
}
	
function queueMovement(movementFunc,args,exitValMin,exitValMax,finFunc=function(){}){
	ds_queue_enqueue(movementQueue,[movementFunc,args,exitValMin,exitValMax,finFunc])
}



randomize()

room_goto(Cockpit)