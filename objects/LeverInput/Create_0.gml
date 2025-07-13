// Inherit the parent event
event_inherited();

_start = {x:1204+240, y:864}
_end = {x:1267+240, y:909}

x = _start.x
y = _start.y

_xdiff = _end.x - _start.x
_ydiff = _end.y - _start.y

currPos = {x:1204+240,y:864}

interaction_shape = "circle";
interaction_radius = 50
interaction_width = 100;
interaction_height = 100;
interaction_priority = 10

pctPulled = 0

function on_interaction_start(){
	window_set_cursor(cr_none)
}
function on_interaction_update(){
	getPositionPulled()
	ControllerService.shipStatus.comms.leverState = pctPulled
	if ControllerService.shipStatus.comms.startupState.currentState.name == "enable"
		ControllerService.shipStatus.comms.crtAstigma.yv += (pctPulled - 0.5)*0.0004
}

function on_interaction_end() {
	window_set_cursor(cr_default)
	
	x = _start.x + _xdiff*0.5
	y = _start.y + _ydiff*0.5
	
	ControllerService.shipStatus.comms.leverState = 0.5

	setMousePosition(x,y)
	
}

