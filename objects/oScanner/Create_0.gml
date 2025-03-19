// Inherit the parent event
event_inherited();
interaction_priority = 10
interaction_shape = "circle"
interaction_radius = 32

x = 1300
y = 800

state = "off"
timer = 0

function on_interaction_end(){
	timer = 0
	state = "scanIn"
	audio_play_sound(printer,1,0)
	
	//if oMapMaster.state.scanningState == "off"
	//	oMapMaster.state.scanningState = "prune"	
}

function resetState(){
	isScanning = false
	errorColor = c_white
	audio_play_sound(printer,1,0)
	timer = 0
	state = "scanOut"
}

debugMapAnimated = true

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


