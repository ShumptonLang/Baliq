function mouseInBounds(oPos, radius, isCircular=false){
	
	var _x = device_mouse_x_to_gui(0)
	var _y = device_mouse_y_to_gui(0)

	
	return (_x > oPos.x - radius && _x < oPos.x + radius  && _y > oPos.y - radius && _y < oPos.y + radius)
}