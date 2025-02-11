//The Job of the ShipMaster is to hold all statuses of each object

global.mouse_occupied = 0
global.mouse_occupied_changed = false
lastMOccupiedInterim = 0
global.lastMouseOccupied = 0
global.currMapBuffer = -1
global.noiseBuffer = -1

instance_create_depth(0,0,0,AudioService)
timers = array_create(0)

shipStatus = {
	sonarLidar: {
		sonarScanning : false,
		sonarLidarSwitchEngaged : false,
		sonarScanTime : 0,
		lidarScanning: false,
		lidarScanTime: 0,
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

#region Lidar Audio Service
function updateLidarSound(event) {
		if ShipMaster.shipStatus.sonarLidar.lidarScanning{
			if fmod_studio_event_instance_get_playback_state(event) == FMOD_STUDIO_PLAYBACK_STATE.STOPPED {
				fmod_studio_event_instance_start(event)
			}
			fmod_studio_event_instance_set_parameter_by_name(event, "lidarEngaged", 1)
		}
		else
			fmod_studio_event_instance_set_parameter_by_name(event, "lidarEngaged", 0)
			
}

function killLidarSound(event) {
		return false
}
	
AudioService.play(AudioService.eventLidarEngagedI,updateLidarSound,killLidarSound)
#endregion

function getValue(roomid, value){
		return variable_struct_get(variable_struct_get(shipStatus,roomid),value)
}

function startTimer(shipStatusTimer, timerGoal, goalFunc){
	array_insert(timers,0,{timerCurrentValue: shipStatusTimer, goal:timerGoal, goalFunc:goalFunc})	
}





randomize()