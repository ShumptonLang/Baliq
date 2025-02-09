

switch(status) {
	case "idle":
	
		
	if global.mouse_occupied == self{
		if (x >= initPos[0] + range){
			status = "engaged"
			master.updateStatus("lidarEngaged", true)
			break
		}
		
		var _x = device_mouse_x_to_gui(0)
		var _y = device_mouse_y_to_gui(0)
	
		var new_angle = point_direction(x,y,_x,_y)
	
		var pull_dir = sqr(dcos(new_angle))
		var delta_pulled = (_x-x)*abs(pull_dir)
		//delta_pulled = _x
		x += delta_pulled
	}
	else {
		x -= x/(initPos[0] + range)*range*0.1
	}

	break;
	
	
	
}
	
x = clamp(x,initPos[0],initPos[0] + range)

	









	
	
