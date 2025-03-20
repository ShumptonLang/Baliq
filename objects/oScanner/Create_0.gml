// Inherit the parent event
event_inherited();
interaction_priority = 10
interaction_shape = "circle"
interaction_radius = 16

x = 1198
y = 45



state = ControllerService.shipStatus.map.stateMachine

function on_interaction_end(){
	if state.getState().name == "off"
		state.changeState("scanIn")
	//print(state.getState().name)
	
	//if oMapMaster.state.scanningState == "off"
	//	oMapMaster.state.scanningState = "prune"	
}


	
	
	












