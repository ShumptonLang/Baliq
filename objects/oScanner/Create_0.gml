// Inherit the parent event
event_inherited();
interaction_priority = 10
interaction_shape = "circle"
interaction_radius = 32

x = 1300
y = 800



state = ControllerService.shipStatus.map.stateMachine

function on_interaction_end(){
	if state.getState().name == "off"
		state.changeState("scanIn")
	print(state.getState().name)
	
	//if oMapMaster.state.scanningState == "off"
	//	oMapMaster.state.scanningState = "prune"	
}


	
	
	
debugMapAnimated = true

// Time in seconds to input the map
timerScanIn = 1
timerWait1 = 1
timerScanScan = 3
timerWait2 = 2
timerScanOut = 1

maxMapOffset = -1000




#region State Machine
var idleState = new State("off")
var navState = new State("navigating")

var scanInState = new State("scanIn")
scanInState.enter = function() {
	audio_play_sound(printer,1,0)
	ControllerService.registerTimer(timerScanIn,function() {
		state.changeState("wait1")	
	}, function(elapsed) {
		if (debugMapAnimated)
            ControllerService.shipStatus.map.printerOffset = (elapsed/1000) / timerScanIn * maxMapOffset;
	})
}


var wait1State = new State("wait1")
wait1State.enter = function(){
	ControllerService.registerTimer(timerWait1, function(){
		state.changeState("scanScan")	
	})
}


var scanScanState = new State("scanScan")
scanScanState.enter = function(){
	audio_play_sound(sonarlaser,1,0,1,0,2)
	ControllerService.registerTimer(timerScanScan, function(){
		state.changeState("wait2")	
	})
}


var wait2State = new State("wait2")
wait2State.enter = function(){
	audio_stop_sound(sonarlaser)
	ControllerService.shipStatus.map.isScanning = true
	if array_length(ControllerService.shipStatus.map.navPath) {
		ControllerService.shipStatus.map.isErrored = false
		state.changeState("navigating")
		if ControllerService.shipStatus.map.scanningState == "off"
			ControllerService.shipStatus.map.scanningState = "prune"
	} else {
		ControllerService.shipStatus.map.isErrored = true
		ControllerService.registerTimer(timerWait2, function(){
			state.changeState("scanOut")	
		})
	}
}


var scanOutState = new State("scanOut")
scanOutState.enter = function() {
	audio_play_sound(printer,1,0)
	ControllerService.shipStatus.map.isScanning = false
	ControllerService.registerTimer(timerScanOut,function() {
		state.changeState("off")	
	}, function(elapsed) {
		if (debugMapAnimated)
            ControllerService.shipStatus.map.printerOffset = (1-(elapsed/1000) / timerScanOut) * maxMapOffset;
	})
}


state.addState("off",idleState)
state.addState("navigating",navState)
state.addState("scanIn",scanInState)
state.addState("wait1",wait1State)
state.addState("scanScan", scanScanState)
state.addState("wait2",wait2State)
state.addState("scanOut",scanOutState)

state.changeState("off")

#endregion





