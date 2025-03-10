//The Job of the ShipMaster is to hold all statuses of each object
global.debug = true


gameStarting = true

forward = {x:lengthdir_x(1,self.angle),y:lengthdir_y(1,self.angle)}

#region Navigation Parameters
forwardPct = 0
forwardV = 0
maxForwardV = 1

rotationPct = 0
minRotV = 0.1
rotationV = 0
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




instance_create_depth(0,0,0,AudioService)
timers = array_create(0)

shipStatus = {
	sonarLidar: {
		sonarScanning : false,
		sonarLidarSwitchEngaged : false,
		sonarScanTime : 0,
		lidarScanning: false,
		lidarScanTime: 0,
		lidarStatus : "idle",
		forwardLever: 0,
		rotationWheel: 0,
		compassDeg:35
	}, 
	digestive: {
		running: 1,
		compSwitchPositions : [0,0,0,0],
		ignitionState : "sleeping",
		ignitionSwitchStates : [4,3,4,2,1],
		waterVolume : 0.0
	},
	eyeCast: {
		camREnabled: 0,
		camRState: "dist"
	}
	
}



function getValue(roomid, value){
		return variable_struct_get(variable_struct_get(shipStatus,roomid),value)
}
	
	function nil(){
		
	}

/**
 * Creates a timer that is handled by the ShipMaster. 
 * @param {any*} shipStatusTimer The ShipMaster Status to reference.
 * @param {any*} timerGoal The amount of time the timer will exist for.
 * @param {any*} goalFunc A function that is called when the timer reaches its goal
 * @param {function} [updFunc]=nil An optional function that is called every timer tick. The update function is passed the current time of the timer.
 */
function startTimer(shipStatusTimer, timerGoal, goalFunc,updFunc = nil){
	
	array_insert(timers,0,{timerCurrentValue: shipStatusTimer, goal:timerGoal, goalFunc:goalFunc, update:updFunc})	
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
	
}

function orientToPoint(targetX,targetY,startingAngleDiff){
	
	
	
	var currDiff = angle_difference(ShipMaster.angle , point_direction(ShipMaster.posx,ShipMaster.posy,targetX,targetY))
	var pctComplete = currDiff/startingAngleDiff
	var rotDir = -sign(currDiff)
	var rotSpeed = 0
	
	if pctComplete < 0.5 {
		rotSpeed = smoothstep(0,1,pctComplete*2)*rotDir*maxRotationV
	} 
	else
	{
		rotSpeed = smoothstep(0,1,1-(pctComplete-0.5)*2)*rotDir*maxRotationV
	}
	
	rotSpeed = rotSpeed + minRotV*rotDir*abs(pctComplete*2-1)

	
	setMovement(,rotSpeed)
	
	return 1 - pctComplete
}


randomize()

