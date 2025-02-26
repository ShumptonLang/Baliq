var _x = device_mouse_raw_x(0)
var _y = device_mouse_raw_y(0)

if global.mouse_occupied_changed and global.mouse_occupied != self{
	
	switch (state.activeTool){
		
		case "pencil":
		window_mouse_set(virtualMouse.x/4.15 + mapXMin,virtualMouse.y/4.15+mapYMin)
		break
		
		case "protractor":
		if state.protractorState == 1 {
			state.protractorDst.x = _x
			state.protractorDst.y = _y
		}
		
		if state.protractorState == 2 {
			state.protractorDst2.x = _x
			state.protractorDst2.y = _y
		}
		
		state.protractorState = (state.protractorState + 1)%4
		
		if state.protractorState == 0 {
			state.protractorDrawing = false
		}
		break
		
	}
}