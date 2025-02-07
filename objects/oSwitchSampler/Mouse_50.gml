if (!global.mouse_occupied){
	var _x = device_mouse_x_to_gui(0)
	var _y = device_mouse_y_to_gui(0)
	var relx = x
	var rely = y
	
	if _x > relx - 100 && _x < relx + 100 && _y > rely - 27 && _y < rely+27
	{
		global.mouse_occupied = self

	}
}
