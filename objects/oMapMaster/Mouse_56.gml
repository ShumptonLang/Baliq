if (!global.mouse_occupied){
	var _x = device_mouse_x_to_gui(0)
	var _y = device_mouse_y_to_gui(0)

	

	if mouseInBounds(protractorPos,50) {
		state.activeTool = "protractor"	
	}
	
	
}