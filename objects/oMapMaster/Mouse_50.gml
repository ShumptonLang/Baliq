if (!global.mouse_occupied){
	var _x = device_mouse_x_to_gui(0)
	var _y = device_mouse_y_to_gui(0)
	
	if mouseInBounds({x:60,y:450},100){
		state.magnifyerUp = true
	}
	
	if mouseInBounds({x:1055,y:450},100){
		print("closed!")
		state.magnifyerUp = false
	}
	
	if mouseInBounds({x:231+482, y:58+482},482)
	{
		global.mouse_occupied = self
		lastX = _x - mapXMin
		lastY = _y - mapYMin
		virtualMouse.x = lastX *4.15
		virtualMouse.y = lastY*4.15
		virtualMouse.lx = lastX*4.15
		virtualMouse.ly = lastY*4.15
	}

}