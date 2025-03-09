event_inherited()

is_interactive = true;
interaction_priority = 0;
interaction_shape = "custom";


if !variable_struct_exists(ShipMaster.shipStatus, "map")
	ShipMaster.shipStatus.map = {
		activeTool: "pencil",
		magnifyerUp: false,
		magnifyerPos: {x:1000,y:2000},
		color: c_black,
		scanningState: "off"
	}
state = ShipMaster.shipStatus.map

magMapTL = {x:0,y:193}
magMapBR = {x:886,y:886}
magMapH = magMapBR.y - magMapTL.y
magMapW = magMapBR.x - magMapTL.x

wasDragging = false
rotateMaxV = 1
rotateV = 0

lastX = device_mouse_x_to_gui(0)
lastY = device_mouse_y_to_gui(0)
virtualMouse = {x:0,y:0,lx:0,ly:0,tx:-100,ty:-100}
mouseSFactor = 0.5

navPath = array_create(0)

#region Map Vertexes
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_color()
vertex_format_add_texcoord()
format = vertex_format_end();

drawingBuffer = vertex_create_buffer();



mapW = 1000
mapH = 1000

mapXMin = 231
mapYMin = 58
mapXMax = mapXMin + mapW
mapYMax = mapYMin + mapH


vertex_begin(drawingBuffer,format);

vertex_position_3d(drawingBuffer,   mapXMin, mapYMin, 0); vertex_color(drawingBuffer, c_white, 1); vertex_texcoord(drawingBuffer, 0,0)
vertex_position_3d(drawingBuffer,   mapXMax, mapYMin, 0); vertex_color(drawingBuffer, c_white, 1); vertex_texcoord(drawingBuffer, 1,0);
vertex_position_3d(drawingBuffer,   mapXMax, mapYMax, 0); vertex_color(drawingBuffer, c_white, 1); vertex_texcoord(drawingBuffer, 1, 1);
vertex_position_3d(drawingBuffer,	mapXMin, mapYMax, 0); vertex_color(drawingBuffer, c_white, 1); vertex_texcoord(drawingBuffer, 0, 1);

vertex_position_3d(drawingBuffer,   mapXMin, mapYMin, 0); vertex_color(drawingBuffer, c_white, 1); vertex_texcoord(drawingBuffer, 0,0)

vertex_end(drawingBuffer)
#endregion

instance_create_depth(0,0,0,oMapInk)
instance_create_depth(0,0,0,oMapEraser)
instance_create_depth(0,0,0,oMagnifyer)
instance_create_depth(0,0,-1,oScanner)

function on_interaction_update() {

	if wasDragging {
		var dX = window_mouse_get_delta_x() * mouseSFactor
		var dY = window_mouse_get_delta_y() * mouseSFactor
	
		state.magnifyerPos.x -= dX
		state.magnifyerPos.y -= dY
		
	}
	else {
    switch (state.activeTool){
		
		case "pencil":
			
			var dX = window_mouse_get_delta_x() * mouseSFactor
			var dY = window_mouse_get_delta_y() * mouseSFactor
			
			if state.magnifyerUp{
				dX *= 0.25
				dY *= 0.25
			}
	
			virtualMouse.x += dX * surface_get_width(global.mapSurf) / mapW
			virtualMouse.y += dY * surface_get_height(global.mapSurf) / mapH

			if surface_exists(global.mapSurf) {
				surface_set_target(global.mapSurf)
				//print(virtualMouse, _x, _y)
				if state.magnifyerUp {
					if state.color == c_red
						array_insert(navPath,0,{x:virtualMouse.x+state.magnifyerPos.x,y:virtualMouse.y+state.magnifyerPos.y})
					draw_line_width_color(virtualMouse.lx+state.magnifyerPos.x,virtualMouse.ly+state.magnifyerPos.y,virtualMouse.x+state.magnifyerPos.x,virtualMouse.y+state.magnifyerPos.y,3,state.color,state.color)
				}
				else
				{
					if state.color == c_red
						array_insert(navPath,0,{x:virtualMouse.x,y:virtualMouse.y})
					draw_line_width_color(virtualMouse.lx,virtualMouse.ly,virtualMouse.x,virtualMouse.y,7,state.color,state.color)
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
			
			if state.magnifyerUp{
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
				if state.magnifyerUp
					draw_line_width_color(virtualMouse.lx+state.magnifyerPos.x,virtualMouse.ly+state.magnifyerPos.y,virtualMouse.x+state.magnifyerPos.x,virtualMouse.y+state.magnifyerPos.y,12,c_black,c_black)
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
}

function interaction_contains_point(x, y) {
    if state.magnifyerUp {
		
		return mouseInRecBounds(magMapTL,magMapBR) or mouseInRecBounds({x:mapXMin, y:mapYMin},{x:mapXMax, y:mapYMax})
		
	}
	
    return mouseInRecBounds({x:mapXMin, y:mapYMin},{x:mapXMax, y:mapYMax});
}

function on_interaction_start() {

	wasDragging = mouseInRecBounds({x:mapXMin, y:mapYMin},{x:mapXMax, y:mapYMax}) and not mouseInRecBounds(magMapTL,magMapBR) and state.magnifyerUp
	
	window_set_cursor(cr_none)
	
	if state.magnifyerUp {
		lastX = oInputManager.mouse_x_gui 
		lastY = oInputManager.mouse_y_gui
		virtualMouse.x = (lastX - magMapTL.x)
		virtualMouse.y = (lastY - magMapTL.y)
		virtualMouse.lx = (lastX - magMapTL.x)
		virtualMouse.ly = (lastY - magMapTL.y)
		virtualMouse.tx = lastX
		virtualMouse.ty = lastY
	} else {
	    lastX = oInputManager.mouse_x_gui 
		lastY = oInputManager.mouse_y_gui
		virtualMouse.x = (lastX - mapXMin) * surface_get_width(global.mapSurf) / mapW 
		virtualMouse.y = (lastY - mapYMin) * surface_get_height(global.mapSurf) / mapH
		virtualMouse.lx = (lastX - mapXMin) * surface_get_width(global.mapSurf) / mapW 
		virtualMouse.ly = (lastY - mapYMin) * surface_get_height(global.mapSurf) / mapH
		virtualMouse.tx = lastX
		virtualMouse.ty = lastY
	}
	
	window_mouse_set_locked(1)
}

function on_interaction_end(){
	window_mouse_set_locked(0)
	if state.magnifyerUp and ! wasDragging
		window_mouse_set(virtualMouse.x + magMapTL.x,virtualMouse.y+magMapTL.y)
	else
		window_mouse_set(virtualMouse.x/4 + mapXMin,virtualMouse.y/4+mapYMin)
	if wasDragging {
		window_mouse_set(lastX,lastY)
	}
	wasDragging = false
	
	virtualMouse.tx = -100
	virtualMouse.ty = -100
}
