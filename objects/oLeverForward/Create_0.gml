event_inherited()



_start = {x:1033,y:670}
_end = {x:1033,y:1042}


x = _start.x
y = _start.y

_xdiff = _end.x - _start.x
_ydiff = _end.y - _start.y

lastPctPulled = 0

currPos = {x:1186,y:673}


interaction_shape = "custom";
interaction_width = 400;
interaction_height = 100;
interaction_priority = 10

in_interaction = false

pctPulled = ControllerService.shipStatus.forwardLever.pctPulled

// Register with input manager on creation


function on_interaction_start() {
    //window_set_cursor(cr_none)
	in_interaction = true
}

function on_interaction_update() {
	
	
	getPositionPulled()
	
	if ControllerService.shipStatus.forwardLever.pctPulled - (ControllerService.shipStatus.forwardLever.pctPulled % 0.10) > lastPctPulled - (lastPctPulled % 0.10) {
		
		audio_play_sound(click,1,0, 0.1)
			
	}
	lastPctPulled = ControllerService.shipStatus.forwardLever.pctPulled
	ShipMaster.offsetMovement(0.04*ControllerService.shipStatus.forwardLever.pctPulled)
	ControllerService.shipStatus.forwardLever.pctPulled = pctPulled

}

	
function on_interaction_end(){
	window_mouse_set(x,y)	
	window_set_cursor(cr_default)
	ControllerService.shipStatus.forwardLever.pctPulled = 0
	in_interaction = false
}

function interaction_contains_point(x, y) {
	if point_distance(currPos.x,currPos.y,x,y) < 100 and ControllerService.shipStatus.ship.navigationState == "followingPath"
		return true
}