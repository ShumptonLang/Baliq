var _x = device_mouse_x_to_gui(0)
var _y = device_mouse_y_to_gui(0)



	
	
	
	

if global.mouse_occupied == "mapDrag"{
	var dX = (_x - lastX) * mouseSFactor
	var dY = (_y - lastY) * mouseSFactor
	
	state.magnifyerPos.x -= dX
	state.magnifyerPos.y -= dY
	
	window_mouse_set(lastX,lastY)
}
