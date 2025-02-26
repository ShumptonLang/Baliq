var _x = device_mouse_x_to_gui(0)
var _y = device_mouse_y_to_gui(0)

print(_x, _y)

if global.mouse_occupied == self {
	
	
	
	switch (state.activeTool){
		
		case "pencil":
			
			var dX = (_x - lastX) * mouseSFactor
			var dY = (_y - lastY) * mouseSFactor
			
			if state.magnifyerUp{
				dX *= 0.25
				dY *= 0.25
			}
	
			virtualMouse.x += dX * surface_get_width(global.mapSurf) / mapW
			virtualMouse.y += dY * surface_get_height(global.mapSurf) / mapH

			if surface_exists(global.mapSurf) {
				surface_set_target(global.mapSurf)
				//print(virtualMouse, _x, _y)
				if state.magnifyerUp
					draw_line_width_color(virtualMouse.lx+state.magnifyerPos.x,virtualMouse.ly+state.magnifyerPos.y,virtualMouse.x+state.magnifyerPos.x,virtualMouse.y+state.magnifyerPos.y,3,c_black,c_dkgray)
				else
					draw_line_width_color(virtualMouse.lx,virtualMouse.ly,virtualMouse.x,virtualMouse.y,7,c_black,c_dkgray)
				
				surface_reset_target()
			}
			window_mouse_set(lastX,lastY)
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
if global.mouse_occupied == "mapDrag"{
	var dX = (_x - lastX) * mouseSFactor
	var dY = (_y - lastY) * mouseSFactor
	
	state.magnifyerPos.x -= dX
	state.magnifyerPos.y -= dY
	
	window_mouse_set(lastX,lastY)
}
