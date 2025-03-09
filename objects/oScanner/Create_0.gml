// Inherit the parent event
event_inherited();
interaction_priority = 10

x = 1300
y = 800

function on_interaction_end(){
	oMapMaster.state.scanningState = "prune"	
}

