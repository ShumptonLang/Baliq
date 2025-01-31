

var _x = device_mouse_x_to_gui(0)
var _y = device_mouse_y_to_gui(0)

if global.mouse_occupied_changed
	reject_mouse = false
	
if reject_mouse and lockPoint == 1 {
	if 	_y <= _start[1]{ 
		lockPoint = 0
		audio_play_sound(click,1,0)
		pctPulled = 0
	}
	if _y >= _end[1] {
		lockPoint = 2
		audio_play_sound(click,1,0)
		pctPulled = 1
	}
}


if(global.mouse_occupied == self and ! reject_mouse){
	
	
	var new_angle = point_direction(x,y,_x,_y)
	
	var pull_dir = sqr(dcos(new_angle+90))
	var delta_pulled = (_y-y)*abs(pull_dir)

	pctPulled += delta_pulled*0.001
	pctPulled = clamp(pctPulled,0,1)
	
	if lockPoint == 0 or lockPoint == 2 {
		if pctPulled > 0.45 and pctPulled < 0.55 {
			lockPoint = 1
			audio_play_sound(click,1,0)
			reject_mouse = true
		}
	} else {
		if pctPulled <= 0 {
			lockPoint = 0
			audio_play_sound(click,1,0)
			reject_mouse = true
		} else if pctPulled >= 1 {
			lockPoint = 2
			audio_play_sound(click,1,0)
			reject_mouse = true
		}
		
	}


	
}
	
if(global.mouse_occupied_changed && global.lastMouseOccupied == self) {
		window_mouse_set(x,y)
}
x = _start[0] + pctPulled*_xdiff
y = _start[1] + pctPulled * _ydiff


ship_master.forward_normal = lockPoint





	
	
