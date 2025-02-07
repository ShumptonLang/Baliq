if (!global.mouse_occupied){
	var _x = device_mouse_x_to_gui(0)
	var _y = device_mouse_y_to_gui(0)
	if point_distance(1275,200,_x,_y) < 50
	{
		global.mouse_occupied = self
	}
}


