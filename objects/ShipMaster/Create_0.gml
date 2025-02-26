//The Job of the ShipMaster is to hold all statuses of each object
global.debug = true
global.mouse_occupied = 0
global.mouse_occupied_changed = false
lastMOccupiedInterim = 0
global.lastMouseOccupied = 0

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

distSurf = surface_create(250,250)
distSurf2= surface_create(250,250)

surface_set_target(distSurf)
draw_clear(c_black)
surface_reset_target()

surface_set_target(distSurf2)
draw_clear(c_black)
surface_reset_target()

global.distSurfs = [distSurf,distSurf2,false]



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
		rotationWheel: 0
	}, 
	digestive: {
		running: 1,
		compSwitchPositions : [0,0,0,0],
		ignitionState : "sleeping",
		ignitionSwitchStates : [4,3,4,2,1],
		waterVolume : 0.0
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





randomize()