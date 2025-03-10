// Inherit the parent event
event_inherited();
interaction_priority = 10
interaction_shape = "circle"
interaction_radius = 32

x = 1300
y = 800

function on_interaction_end(){
	if oMapMaster.state.scanningState == "off"
		oMapMaster.state.scanningState = "prune"	
}

