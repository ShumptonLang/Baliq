function mouseInRecBounds(oPos1, oPos2){
	
	var _x = device_mouse_x_to_gui(0)
	var _y = device_mouse_y_to_gui(0)

	
	return (_x > oPos1.x && _x < oPos2.x && _y > oPos1.y  && _y < oPos2.y )
}