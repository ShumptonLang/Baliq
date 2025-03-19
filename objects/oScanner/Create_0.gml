// Inherit the parent event
event_inherited();
interaction_priority = 10
interaction_shape = "circle"
interaction_radius = 32

x = 1300
y = 800



state = new StateMachine(self)

function on_interaction_end(){
	if state.getState().name == "off"
		state.changeState("scanIn")
	print(state.getState().name)
	
	//if oMapMaster.state.scanningState == "off"
	//	oMapMaster.state.scanningState = "prune"	
}

function resetState(){
	isScanning = false
	errorColor = c_white

	state.changeState("off")
}
	
	
	
debugMapAnimated = false

// Time in seconds to input the map
timerScanIn = 1
timerWait1 = 1
timerScanScan = 3
timerWait2 = 2
timerScanOut = 1

maxMapOffset = -1000


mapOffset = 0
isScanning = false
isErrored = false

#region State Machine
var idleState = new State("off")
var navState = new State("navigating")

var scanInState = new State("scanIn")
scanInState.enter = function() {
	other.timer = 0
	audio_play_sound(printer,1,0)
	print("ScanInEnter")
}
scanInState.execute = function() {
	other.timer += delta_time / 1000000	
	print("ScanInUpdate")
	if (debugMapAnimated)
        mapOffset = other.timer / timerScanIn * maxMapOffset;
    
    if (other.timer > timerScanIn) {
        state.changeState("wait1");
    }
}

var wait1State = new State("wait1")
wait1State.enter = function(){
	other.timer = 0
}
wait1State.execute = function() {
	other.timer += delta_time / 1000000	
	if (other.timer > timerWait1) {
        state.changeState("scanScan");
    }
}

var scanScanState = new State("scanScan")
scanScanState.enter = function(){
	audio_play_sound(sonarlaser,1,0,1,0,2)
	other.timer = 0
}
scanScanState.execute = function(){
	other.timer += delta_time / 1000000	
	if (other.timer > timerScanScan) {
        state.changeState("wait2");
    }
}

var wait2State = new State("wait2")
wait2State.enter = function(){
	audio_stop_sound(sonarlaser)
	isScanning = true
	other.timer = 0
}
wait2State.execute = function(){
	other.timer += delta_time / 1000000	
	if array_length(oMapMaster.navPath) {
			isErrored = false
			state.changeState("navigating")
			if oMapMaster.state.scanningState == "off"
				oMapMaster.state.scanningState = "prune"
		} else {
			isErrored = true
			if other.timer > timerWait2 {
				state.changeState("scanOut")
			}
		}
}

var scanOutState = new State("scanOut")
scanOutState.enter = function() {
	other.timer = 0
	audio_play_sound(printer,1,0)
	isScanning = false
}
scanOutState.execute = function() {
	other.timer += delta_time / 1000000	
	if debugMapAnimated
			mapOffset = (1- other.timer/timerScanOut) * maxMapOffset
	if other.timer > timerScanOut {
		state.changeState("off")

		}
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





