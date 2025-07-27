


shipStatus = {
	sonarLidar: {
		sonarScanning : false,
		sonarLidarSwitchEngaged : false,
		sonarScanTime : 0,
		lidarScanning: false,
		lidarScanTime: 0,
		lidarStatus : "idle",
		forwardLever: 0,
		rotationWheel: {
			one:0,
			two:0,
			delta:0
		},
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
		navigationState: "none",
		velocity : 0,
		ambienceLaugh: 0
	},
	map: {
		printerOffset: 0,
		isErrored: false,
		stateMachine: new StateMachine(oScanner),
		activeTool: "pencil",
		magnifyerUp: false,
		magnifyerPos: {x:1000,y:2000},
		color: c_black,
		navPath: array_create(0)
	},
	balasts: {
		rStateMachine: new StateMachine(oBallastMaster),
		rVolume:1,
		lVolume:1
	},
	distApp: {
		distanceSurface: surface_create(128,256),
		timesVisited: 0,
		hasLaughed: false
	},
	comms: {
		startupState: new StateMachine(CommsMaster),
		leverState: 0,
		totalPeriphAlpha: 1,
		introState: 0,
		bigDialState: 0,
		PowerDialState: 0,
		smallSwitchState: 0,
		introSpriteStates:{
			engine:0,
			speakers:0,
			crt:0,
			hideAll:0
		},
		crtAstigma: {x:1,y:1,focus:0,xv:0,yv:0}
	}
}

roomStack = array_create(1,room)
offlimitRooms = [MapTest,Cockpit]
roomLock = false



timers = array_create(0)
stateMachines = array_create(0)
	


/**
 * Creates a timer that is handled by the ControllerService. 
 * @param {any*} timerGoal The amount of time the timer will exist for.
 * @param {any*} goalFunc A function that is called when the timer reaches its goal
 * @param {function} [updFunc]=nil An optional function that is called every timer tick. The update function is passed the current time of the timer.
 */
function registerTimer(duration, goalFunc,updFunc = function(){}, args = []){
	var timer = {
		startTime: current_time,
		duration: duration * 1000,
		callback : goalFunc,
		update : updFunc
	}
		
	array_push(timers,timer)
}
	
	

#region Scanner State Machine
debugMapAnimated = false

// Time in seconds to input the map
timerScanIn = 1
timerWait1 = 1
timerScanScan = 3
timerWait2 = 2
timerScanOut = 1

maxMapOffset = -1000


var idleState = new State("off")
var navState = new State("navigating")
navState.enter = function(){
	ShipMaster.navPath()	
}

var scanInState = new State("scanIn")
scanInState.enter = function() {
	audio_play_sound(printer,1,0)
	ControllerService.registerTimer(timerScanIn,function() {
		shipStatus.map.stateMachine.changeState("wait1")	
	}, function(elapsed) {
		if (debugMapAnimated)
            ControllerService.shipStatus.map.printerOffset = (elapsed/1000) / timerScanIn * maxMapOffset;
	})
}


var wait1State = new State("wait1")
wait1State.enter = function(){
	ControllerService.registerTimer(timerWait1, function(){
		shipStatus.map.stateMachine.changeState("scanScan")	
	})
}


var scanScanState = new State("scanScan")
scanScanState.enter = function(){
	audio_play_sound(shortHiBeep,1,0)
	audio_play_sound(sonarlaser,1,0,0.5,0,0.2)
	ControllerService.registerTimer(timerScanScan, function(){
		shipStatus.map.stateMachine.changeState("wait2")	
	})
}


var wait2State = new State("wait2")
wait2State.enter = function(){
	audio_stop_sound(sonarlaser)
	if array_length(ControllerService.shipStatus.map.navPath) >= 2 {
		ControllerService.shipStatus.map.isErrored = false
		shipStatus.map.stateMachine.changeState("waitPlayer")
		audio_play_sound(repeatedBeep,1,1,0.5)
		ShipMaster.pruneNavPath()
		
	} else {
		ControllerService.shipStatus.map.isErrored = true
		ControllerService.registerTimer(timerWait2, function(){
			shipStatus.map.stateMachine.changeState("scanOut")	
		})
	}
}

//Waits for the player to enter the mapping area before opening the priming tools
var waitForPlayer = new State("waitPlayer")
waitForPlayer.execute = function() {
	if room == Sonar or room == Ignition{
		shipStatus.map.stateMachine.changeState("waitIgnition")	
		
		
	
		ControllerService.registerTimer(2,function(){
			audio_stop_sound(metalbend)
			audio_play_sound(click,1,0,1,0,0.5)
		},
		function(elapsed) {
			ControllerService.shipStatus.sonarLidar.emergingToolAlpha = elapsed/2/1000
		})
	}
}

var waitForIgnition = new State("waitIgnition")
waitForIgnition.execute = function(){
	if ControllerService.shipStatus.sonarLidar.rotationWheel.one >= 0.99
	and ControllerService.shipStatus.sonarLidar.rotationWheel.two >= 0.99
	and ControllerService.shipStatus.sonarLidar.forwardLever >= 0.99 {
			shipStatus.map.stateMachine.changeState("navigating")
			ControllerService.registerTimer(2,function(){
			audio_stop_sound(metalbend)
			audio_stop_sound(repeatedBeep)
			audio_play_sound(linuxBeep,1,0,0.5,0,2)
		},
		function(elapsed) {
			ControllerService.shipStatus.sonarLidar.emergingToolAlpha = 1-(elapsed/2/1000)
		})
	}
}

var scanOutState = new State("scanOut")
scanOutState.enter = function() {
	audio_play_sound(printer,1,0)
	ControllerService.shipStatus.sonarLidar.rotationWheel.one = 0
	ControllerService.shipStatus.sonarLidar.rotationWheel.two = 0
	ControllerService.shipStatus.sonarLidar.forwardLever = 0
	ControllerService.registerTimer(timerScanOut,function() {
		shipStatus.map.stateMachine.changeState("off")	
	}, function(elapsed) {
		if (debugMapAnimated)
            ControllerService.shipStatus.map.printerOffset = (1-(elapsed/1000) / timerScanOut) * maxMapOffset;
	})
}


shipStatus.map.stateMachine.addState("off",idleState)
shipStatus.map.stateMachine.addState("navigating",navState)
shipStatus.map.stateMachine.addState("scanIn",scanInState)
shipStatus.map.stateMachine.addState("wait1",wait1State)
shipStatus.map.stateMachine.addState("scanScan", scanScanState)
shipStatus.map.stateMachine.addState("waitPlayer", waitForPlayer)
shipStatus.map.stateMachine.addState("waitIgnition", waitForIgnition)
shipStatus.map.stateMachine.addState("wait2",wait2State)
shipStatus.map.stateMachine.addState("scanOut",scanOutState)

shipStatus.map.stateMachine.changeState("off")

array_push(stateMachines,shipStatus.map.stateMachine)

#endregion
#region Ballast State Machine

var closedState = new State("closed")
var openState = new State("open")
openState.execute = function(){
	ControllerService.shipStatus.balasts.rVolume -= 0.02/60
}

shipStatus.balasts.rStateMachine.addState("closed",closedState)
shipStatus.balasts.rStateMachine.addState("open",openState)

shipStatus.balasts.rStateMachine.changeState("closed")

array_push(stateMachines,shipStatus.balasts.rStateMachine)


#endregion

#region Comms Startup
var off = new State("off")
var sleep = new State("sleep")
var firstEnable = new State("firstEnable")
var enable = new State("enable")
var transition = new State("transition")
var finale = new State("finale")

commsTransitionSequence = new timerSequence([0,4750,6656,6736])

firstEnable.enter = function(){
	audio_play_sound(CommFirstStartup_PowerClickOn,1,0)
	audio_play_sound(CommFirstStartup_FanLoop,1,1)
	ControllerService.registerTimer(3, 
					function(){audio_play_sound(CommFirstStartup_TVStartup,1,0)})
	ControllerService.registerTimer(5, 
					function(){shipStatus.comms.startupState.changeState("enable")
								fmod_studio_event_instance_start(AudioService.commsStartupI)})				
					
}

enable.enter = function(){
	audio_play_sound(CommFirstStartup_PowerClickOn,1,0)
	fmod_studio_event_instance_set_paused(AudioService.commsStartupI,0)
					
}
firstEnable.stop = function() {
	audio_stop_sound(CommFirstStartup_FanLoop)
	audio_play_sound(CommFirstStartup_PowerClickOff,1,0,2)
}
sleep.enter = function(){
	audio_play_sound(CommFirstStartup_PowerClickOff,1,0,2)
	audio_stop_sound(CommFirstStartup_TVLoop)
	fmod_studio_event_instance_set_paused(AudioService.commsStartupI,1)

}
transition.enter = function(){
	audio_play_sound(CommFirstStartup_Transition,1,0,3)
	ControllerService.registerTimer(11.1,
		function(){
			//Needs to set the astigmatism somewhere else
			shipStatus.comms.crtAstigma.x = irandom(1)
			shipStatus.comms.crtAstigma.y = irandom(1)
			
			shipStatus.comms.startupState.changeState("enable")
			shipStatus.comms.introSpriteStates.crt = 0
			audio_play_sound(CommFirstStartup_Spotlight,1,0)
			shipStatus.comms.totalPeriphAlpha = 1
			ControllerService.commsTransitionSequence = new timerSequence([0,4750,6656])
			fmod_studio_event_instance_set_volume(AudioService.commsStartupI, 1)
		},
		function(elapsed){
			//print("Transition Timer at:", elapsed, CommsMaster.rayIntensity, CommsMaster.rayLength )
			switch(ControllerService.commsTransitionSequence.sampleSequence(elapsed)) {
				
				case 0:	
				
				shipStatus.comms.totalPeriphAlpha = 1
					switch(shipStatus.comms.introState) {
						case 0:
							CommsMaster.rayIntensity = 0.0001
							CommsMaster.rayLength = 200
						break
						
						case 1:
							CommsMaster.rayIntensity = 0.001
							CommsMaster.rayLength = 200
						break
						
						case 2:
							CommsMaster.rayIntensity = 0.005
							CommsMaster.rayLength = 300
						break
					}
				break
				
				case 1:
					CommsMaster.rayIntensity = 0.000035
					CommsMaster.rayLength = 10
					shipStatus.comms.introSpriteStates.crt = 1
					//if shipStatus.comms.introState == 0
						fmod_studio_event_instance_set_volume(AudioService.commsStartupI, 0)
				break
				
				
				case 2:
					
					//print(shipStatus.comms.introState)
					
					switch(shipStatus.comms.introState) {
						case 0:
							shipStatus.comms.introSpriteStates.hideAll = true
							shipStatus.comms.introSpriteStates.engine = true
							audio_play_sound(whitNoise,1,0,0.2)
						break
						
						case 1:
						audio_play_sound(CommFirstStartup_Spotlight,1,0,3)
						audio_play_sound(CommFirstStartup_Feedback,1,0,3)
							shipStatus.comms.introSpriteStates.speakers = true
							shipStatus.comms.introState = 2
						break
					}

				break
				
				case 3:
					switch(shipStatus.comms.introState) {
						case 0:
							shipStatus.comms.introSpriteStates.hideAll = false
							shipStatus.comms.introState = 1
							audio_stop_sound(whitNoise)
						break
					}
			}
			
			//if elapsed < 2000{
			//	CommsMaster.rayIntensity = 0.0001
			//	CommsMaster.rayLength = 200
			//}
			//if elapsed > 175 and elapsed < 250{
			//	CommsMaster.rayIntensity = 0.0001
			//	CommsMaster.rayLength = 0
			//}
			//if elapsed > 250 and elapsed < 325{
			//	CommsMaster.rayIntensity = 0.0001
			//	CommsMaster.rayLength = 200
			//}
			//if elapsed > 325 and elapsed < 400{
			//	CommsMaster.rayIntensity = 0.0001
			//	CommsMaster.rayLength = 0
			//}
			//if elapsed > 2000 and elapsed < 4000{
			//	CommsMaster.rayIntensity = 0.000035
			//	CommsMaster.rayLength = 10
			//	shipStatus.comms.introState = 1
			//}
			//if elapsed > 3000 {
			//	if !audio_exists(CommFirstStartup_Engine)
			//		audio_play_sound(CommFirstStartup_Engine)
			//	shipStatus.comms.introSpriteStates.engine = true	
			//}
		})	
}
finale.enter = function () {
	print("Finale Triggering")
	fmod_studio_event_instance_set_paused(AudioService.commsStartupI,1)
	audio_play_sound(CommFirstStartup_Spotlight,1,0,3)
	audio_play_sound(CommFirstStartup_TransitionFinale,1,0,3)
	//shipStatus.comms.introState = 0
	shipStatus.comms.totalPeriphAlpha = 0
	//shipStatus.comms.introSpriteStates.crt = 1
	CommsMaster.rayIntensity = 0.002
	CommsMaster.rayLength = 300
	CommsMaster.chroma = 0.4
}


shipStatus.comms.startupState.addState("off",off)
shipStatus.comms.startupState.addState("sleep",sleep)
shipStatus.comms.startupState.addState("firstEnable",firstEnable)
shipStatus.comms.startupState.addState("enable",enable)
shipStatus.comms.startupState.addState("transition",transition)
shipStatus.comms.startupState.addState("finale",finale)

shipStatus.comms.startupState.changeState("off")

array_push(stateMachines,shipStatus.balasts.rStateMachine)
