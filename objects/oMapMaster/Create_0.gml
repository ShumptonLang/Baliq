event_inherited()

is_interactive = true;
interaction_priority = 0;
interaction_shape = "custom";

startingAngle = 0


lastX = device_mouse_x_to_gui(0)
lastY = device_mouse_y_to_gui(0)
virtualMouse = {x:0,y:0,lx:0,ly:0,tx:-100,ty:-100}
mouseSFactor = 0.5


mapXOrigin = 231
mapYOrigin = 58
currMapX = 231
currMapY = 58

mapW = 1000
mapH = 1000

vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_color()
vertex_format_add_texcoord()
format = vertex_format_end();



mapXOffset = 0
mapYOffset = 0

instance_create_depth(0,0,0,oMapInk)
instance_create_depth(0,0,0,oMapEraser)
//instance_create_depth(0,0,0,oMagnifyer)
instance_create_depth(0,0,-1,oScanner)

function on_interaction_update() {

	switch (ControllerService.shipStatus.map.activeTool){
		
		case "pencil":
			
			var dX = window_mouse_get_delta_x() * mouseSFactor
			var dY = window_mouse_get_delta_y() * mouseSFactor
			
			if ControllerService.shipStatus.map.magnifyerUp{
				dX *= 0.25
				dY *= 0.25
			}
	
			virtualMouse.x += dX * surface_get_width(global.mapSurf) / mapW
			virtualMouse.y += dY * surface_get_height(global.mapSurf) / mapH

			if surface_exists(global.mapSurf) {
				surface_set_target(global.mapSurf)
				//print(virtualMouse, _x, _y)
				if ControllerService.shipStatus.map.magnifyerUp {
					if ControllerService.shipStatus.map.color == c_red
						array_insert(ControllerService.shipStatus.map.navPath,0,{x:virtualMouse.x+ControllerService.shipStatus.map.magnifyerPos.x,y:virtualMouse.y+ControllerService.shipStatus.map.magnifyerPos.y})
					draw_line_width_color(virtualMouse.lx+ControllerService.shipStatus.map.magnifyerPos.x,virtualMouse.ly+ControllerService.shipStatus.map.magnifyerPos.y,virtualMouse.x+ControllerService.shipStatus.map.magnifyerPos.x,virtualMouse.y+ControllerService.shipStatus.map.magnifyerPos.y,3,ControllerService.shipStatus.map.color,ControllerService.shipStatus.map.color)
				}
				else
				{
					if ControllerService.shipStatus.map.color == c_red
						array_insert(ControllerService.shipStatus.map.navPath,0,{x:virtualMouse.x,y:virtualMouse.y})
					draw_line_width_color(virtualMouse.lx,virtualMouse.ly,virtualMouse.x,virtualMouse.y,7,ControllerService.shipStatus.map.color,ControllerService.shipStatus.map.color)
				}
				
				surface_reset_target()
			}
			//window_mouse_set(lastX,lastY)
			virtualMouse.lx = virtualMouse.x
			virtualMouse.ly = virtualMouse.y

			break
			
			
		case "eraser":
			dX = window_mouse_get_delta_x() * mouseSFactor
			dY = window_mouse_get_delta_y() * mouseSFactor
			
			virtualMouse.tx += dX
			virtualMouse.ty += dY
			
			if ControllerService.shipStatus.map.magnifyerUp{
				dX *= 0.25
				dY *= 0.25
			}
	
			virtualMouse.x += dX * surface_get_width(global.mapSurf) / mapW
			virtualMouse.y += dY * surface_get_height(global.mapSurf) / mapH
			
			
			
			

			if surface_exists(global.mapSurf) {
				surface_set_target(global.mapSurf)
				gpu_set_blendmode(bm_subtract)
				draw_set_alpha(0.70 + random(0.1))
				//print(virtualMouse, _x, _y)
				if ControllerService.shipStatus.map.magnifyerUp
					draw_line_width_color(virtualMouse.lx+ControllerService.shipStatus.map.magnifyerPos.x,virtualMouse.ly+ControllerService.shipStatus.map.magnifyerPos.y,virtualMouse.x+ControllerService.shipStatus.map.magnifyerPos.x,virtualMouse.y+ControllerService.shipStatus.map.magnifyerPos.y,12,c_black,c_black)
				else
					draw_line_width_color(virtualMouse.lx,virtualMouse.ly,virtualMouse.x,virtualMouse.y,28,c_black,c_black)
				gpu_set_blendmode(bm_normal)
				draw_set_alpha(1)
				surface_reset_target()
			}
			//window_mouse_set(lastX,lastY)
			virtualMouse.lx = virtualMouse.x
			virtualMouse.ly = virtualMouse.y
			break
	}
	
}

function interaction_contains_point(x, y) {
	
    return mouseInRecBounds({x:mapXOrigin, y:mapYOrigin},{x:mapXOrigin+mapW, y:mapYOrigin+mapH});
}

function on_interaction_start() {

	
	window_set_cursor(cr_none)
	
	
	lastX = oInputManager.mouse_x_gui 
	lastY = oInputManager.mouse_y_gui
	virtualMouse.x = (lastX - currMapX) * surface_get_width(global.mapSurf) / mapW 
	virtualMouse.y = (lastY - currMapY) * surface_get_height(global.mapSurf) / mapH
	virtualMouse.lx = (lastX - currMapY) * surface_get_width(global.mapSurf) / mapW 
	virtualMouse.ly = (lastY - currMapY) * surface_get_height(global.mapSurf) / mapH
	virtualMouse.tx = lastX
	virtualMouse.ty = lastY
	
	
	window_mouse_set_locked(1)
}

function on_interaction_end(){
	window_mouse_set_locked(0)
	
	window_mouse_set(virtualMouse.x/4 + currMapX,virtualMouse.y/4+currMapY)

	
	virtualMouse.tx = -100
	virtualMouse.ty = -100
	
	window_set_cursor(cr_default)
}
	
function finalizeOrientation(){
	ControllerService.shipStatus.ship.navigationState = "followingPath"
	ControllerService.shipStatus.map.stateMachine.changeState("scanOut")
	ControllerService.shipStatus.map.isScanning = false

}
