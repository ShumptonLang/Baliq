

if global.mouse_occupied_changed and global.mouse_occupied != self and global.mouse_occupied != "mapDrag"{
	
	switch (state.activeTool){
		
		case "pencil":
		if !wasDragging {
			if state.magnifyerUp {
				window_mouse_set(virtualMouse.x + magMapTL.x,virtualMouse.y+magMapTL.y)
			} else {
				window_mouse_set(virtualMouse.x/4 + mapXMin,virtualMouse.y/4+mapYMin)
			}
		
			} else {
				wasDragging = false
		}
		break
		
		
	}
}