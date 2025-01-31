if (!global.mouse_occupied){
	var _x = device_mouse_x_to_gui(0)
	var _y = device_mouse_y_to_gui(0)

	
	if point_distance(x,y,_x,_y) < 100
	{
		global.mouse_occupied = self

	}
}
