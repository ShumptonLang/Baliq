// Inherit the parent event
event_inherited();

_start = {x:1204, y:864}
_end = {x:1267, y:908}

x = _start.x
y = _start.y

_xdiff = _end.x - _start.x
_ydiff = _end.y - _start.y

currPos = {x:1204,y:864}

interaction_shape = "custom";
interaction_width = 100;
interaction_height = 100;
interaction_priority = 10

pctPulled = 0

function on_interaction_update(){
	getPositionPulled()
	ControllerService.shipStatus.comms.leverState = pctPulled
	ControllerService.shipStatus.comms.crtAstigma.y += pctPulled - 0.5
}

function on_interaction_end() {
	print("RADLEVERAOK")
}

function interaction_contains_point(x, y) {
	if point_distance(currPos.x,currPos.y,x,y) < 50 
		return true
}