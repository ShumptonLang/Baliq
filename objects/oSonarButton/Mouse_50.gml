if (!global.mouse_occupied){
	var _x = device_mouse_x_to_gui(0)
	var _y = device_mouse_y_to_gui(0)
	if _x > x - 32 && _x < x + 32 && _y > y - 32 && _y < y+32
	{
		global.mouse_occupied = self
		oSonarMaster.scanning = true
	}
}
