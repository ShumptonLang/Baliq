event_inherited()

_start = [1186,673]
_end = [1283,1042]

_xdiff = _end[0] - _start[0]
_ydiff = _end[1] - _start[1]

lastPctPulled = 0

x = _start[0]
y = _start[1]

interaction_shape = "rectangle";
interaction_width = 200;
interaction_height = 54;
interaction_priority = 10

in_interaction = false

// Register with input manager on creation


function on_interaction_start() {
    window_set_cursor(cr_none)
	in_interaction = true
}

function on_interaction_update() {
	
	
	var _x = global.mouseX
	var _y = global.mouseY
	
	var new_angle = point_direction(x,y,_x,_y)
	
	var pull_dir = sqr(dcos(new_angle+90))
	var delta_pulled = (_y-y)*abs(pull_dir)

	pctPulled += delta_pulled*0.001
	pctPulled = clamp(pctPulled,0,1)
	
	if pctPulled - (pctPulled % 0.10) > lastPctPulled - (lastPctPulled % 0.10) {
		
		audio_play_sound(click,1,0, 0.1)
			
	}
	lastPctPulled = pctPulled
	master.updateStatus("leverForward", pctPulled)

}

	
function on_interaction_end(){
	window_mouse_set(x,y)	
	window_set_cursor(cr_default)
	master.updateStatus("leverForward", 0)	
	in_interaction = false
}