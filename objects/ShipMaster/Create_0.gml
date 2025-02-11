//The Job of the ShipMaster is to hold all statuses of each object

global.mouse_occupied = 0
global.mouse_occupied_changed = false
lastMOccupiedInterim = 0
global.lastMouseOccupied = 0

global.currMapBuffer = -1
global.noiseBuffer = -1

global.sonarSurf = -1
global.lidarSurf = -1

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
		running: false,
		compSwitchPositions : [0,0,0,0],
		ignitionState : "sleeping",
		ignitionSwitchStates : [4,3,4,2,1],
		waterVolume : 0.0
	}
}



function getValue(roomid, value){
		return variable_struct_get(variable_struct_get(shipStatus,roomid),value)
}

function startTimer(shipStatusTimer, timerGoal, goalFunc,updFunc = {}){
	
	array_insert(timers,0,{timerCurrentValue: shipStatusTimer, goal:timerGoal, goalFunc:goalFunc, update:updFunc})	
}





randomize()