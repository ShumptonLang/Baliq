if (!global.mouse_occupied && !reject_mouse){
	var _x = device_mouse_x_to_gui(0)
	var _y = device_mouse_y_to_gui(0)
	if _x > x - 27 && _x < x + 27 && _y > y - 100 && _y < y+100
	{
		global.mouse_occupied = self
		falling = engaged
	}
}
