// Inherit the parent event
event_inherited();
interaction_priority = 10
interaction_shape = "circle"
interaction_radius = 32

x = 1300
y = 800

state = "off"

function on_interaction_end(){
	state = "scanIn"
	
	//if oMapMaster.state.scanningState == "off"
	//	oMapMaster.state.scanningState = "prune"	
}

timer = 0
timerG1 = 1200

