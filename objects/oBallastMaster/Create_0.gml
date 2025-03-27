// Inherit the parent event
event_inherited();
interaction_shape = "custom"


interactionPositions = [{x:1331,y:746},{x:1398,y:746}]

function on_interaction_end(){
	ControllerService.shipStatus.balasts.rStateMachine.changeState("closed")
}

function on_interaction_start(){
	ControllerService.shipStatus.balasts.rStateMachine.changeState("open")
}

//1331,746

function interaction_contains_point(x,y){
	
	

	return point_distance(x,y,interactionPositions[0].x,interactionPositions[0].y) < 50
	
	
}