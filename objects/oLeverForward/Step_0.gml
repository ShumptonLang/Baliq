

var _x = device_mouse_x_to_gui(0)
var _y = device_mouse_y_to_gui(0)


	



if(global.mouse_occupied == self){
	
	
	var new_angle = point_direction(x,y,_x,_y)
	
	var pull_dir = sqr(dcos(new_angle+90))
	var delta_pulled = (_y-y)*abs(pull_dir)

	pctPulled += delta_pulled*0.001
	pctPulled = clamp(pctPulled,0,1)
	
	if pctPulled - (pctPulled % 0.10) > lastPctPulled - (lastPctPulled % 0.10) {
		
		audio_play_sound(click,1,0)
			
	}
	lastPctPulled = pctPulled
	
	ship_master.forward_normal = pctPulled * shipSpeed
} else {
	pctPulled = 0.9*pctPulled
	
	if pctPulled - (pctPulled % 0.50) < lastPctPulled -(lastPctPulled % 0.50) {
		
		audio_play_sound(click,1,0)
			
	}
	lastPctPulled = pctPulled
	
	ship_master.forward_normal = 0
}

	
if(global.mouse_occupied_changed && global.lastMouseOccupied == self) {
		window_mouse_set(x,y)
}
x = _start[0] + pctPulled*_xdiff
y = _start[1] + pctPulled * _ydiff








	
	
