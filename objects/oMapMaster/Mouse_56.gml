if (global.mouse_occupied == 0){
	var _x = device_mouse_x_to_gui(0)
	var _y = device_mouse_y_to_gui(0)

	//if mouseInBounds({x:60,y:450},100){
	//	state.magnifyerUp = true
	//}
	
	//if mouseInBounds({x:1055,y:450},100){
	//	print("closed!")
	//	state.magnifyerUp = false
	//}

	if mouseInBounds(protractorPos,50) {
		state.activeTool = "protractor"	
	}
	
	
}