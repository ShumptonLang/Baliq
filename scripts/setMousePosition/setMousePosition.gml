function setMousePosition(x,y){
	var pillarBoxOffset = 240
	var guiToDisplayScaleRatio = display_get_height()/1080
	
	window_mouse_set((x+pillarBoxOffset)*guiToDisplayScaleRatio,y*guiToDisplayScaleRatio)
}