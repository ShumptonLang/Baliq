


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
		compassDeg:35,
		emergingToolAlpha: 0
	},
	forwardLever: {
		pctPulled:0
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
	},
	ship: {
		navigationState: "none"	
	},
	map: {
		printerOffset: 0,
		isScanning : false,
		isErrored: false,
		stateMachine: new StateMachine(oScanner),
		activeTool: "pencil",
		magnifyerUp: false,
		magnifyerPos: {x:1000,y:2000},
		color: c_black,
		scanningState: "off",
		navPath: array_create(0)
	},
	balasts: {
		bLeftVolume:100,
		bRightVolume:100
	}
}





timers = array_create(0)

	
function nil(){
		
	}

/**
 * Creates a timer that is handled by the ShipMaster. 
 * @param {any*} timerGoal The amount of time the timer will exist for.
 * @param {any*} goalFunc A function that is called when the timer reaches its goal
 * @param {function} [updFunc]=nil An optional function that is called every timer tick. The update function is passed the current time of the timer.
 */
function registerTimer(duration, goalFunc,updFunc = nil, args = []){
	var timer = {
		startTime: current_time,
		duration: duration * 1000,
		callback : goalFunc,
		update : updFunc
	}
		
	array_push(timers,timer)
}