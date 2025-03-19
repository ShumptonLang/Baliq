draw_set_color(c_black)
if ControllerService.shipStatus.map.activeTool == "eraser" {
	if ControllerService.shipStatus.map.magnifyerUp	
		draw_circle(virtualMouse.tx,virtualMouse.ty,14,1)
	else
		draw_circle(virtualMouse.tx,virtualMouse.ty,7,1)
}
draw_set_color(c_white)