if global.mouse_occupied == self {
	
	var _x = device_mouse_raw_x(0)
	var _y = device_mouse_raw_y(0)
	
	switch (state.activeTool){
		
		case "pencil":
			_x -= mapXMin
			_y -= mapYMin
	
			var dX = (_x - lastX) * mouseSFactor
			var dY = (_y - lastY) * mouseSFactor
	
			virtualMouse.x += dX * 4.15
			virtualMouse.y += dY * 4.15

			if surface_exists(global.mapSurf) {
				surface_set_target(global.mapSurf)
				if state.magnifyerUp
					draw_line_width_color(virtualMouse.lx,virtualMouse.ly,virtualMouse.x,virtualMouse.y,3,c_black,c_dkgray)
				else
					draw_line_width_color(virtualMouse.lx,virtualMouse.ly,virtualMouse.x,virtualMouse.y,13,c_black,c_dkgray)
				surface_reset_target()
			}
			lastX = _x
			lastY = _y
			virtualMouse.lx = virtualMouse.x
			virtualMouse.ly = virtualMouse.y
			break
			
			
		case "protractor":
			if mouse_check_button(mb_left){
					if !state.protractorDrawing{
						state.protractorDrawing = true
						state.protractorState = 1
						state.protractorSrc = {x:_x, y:_y}
					}
			}
			break
	}
}

