if (global.mouse_occupied == 0){
	var _x = device_mouse_x_to_gui(0)
	var _y = device_mouse_y_to_gui(0)
	
	
	if state.magnifyerUp{
		if mouseInRecBounds(magMapTL,magMapBR)
		{
			global.mouse_occupied = self
			lastX = _x 
			lastY = _y 
			virtualMouse.x = (lastX - magMapTL.x)
			virtualMouse.y = (lastY - magMapTL.y)
			virtualMouse.lx = (lastX - magMapTL.x)
			virtualMouse.ly = (lastY - magMapTL.y)
		}
		
		if mouseInRecBounds({x:mapXMin, y:mapYMin},{x:mapXMax, y:mapYMax}) and !mouseInRecBounds(magMapTL,magMapBR)and !mouseInBounds({x:1055,y:450},100){
			global.mouse_occupied = "mapDrag"
			lastX = _x
			lastY = _y
			wasDragging = true
		}
	}
	else {
		if mouseInRecBounds({x:mapXMin, y:mapYMin},{x:mapXMax, y:mapYMax})
		{

			
		}
	}

}