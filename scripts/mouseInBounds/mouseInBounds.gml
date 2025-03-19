function mouseInBounds(oPos, height,width, isCircular=false){
	
	var _x = device_mouse_x_to_gui(0)
	var _y = device_mouse_y_to_gui(0)

	
	return (_x > oPos.x && _x < oPos.x + width  && _y > oPos.y && _y < oPos.y + height)
}