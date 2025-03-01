event_inherited()

is_interactive = true;
interaction_priority = 0;
interaction_shape = "custom";

state = {
	activeTool: "pencil",
	protractorDrawing: false,
	protractorState: 0, // 0: nothing, 1: lining, 2:angling
	protractorSrc:{x:0,y:0},
	protractorDst:{x:0,y:0},
	protractorDst2:{x:0,y:0},
	magnifyerUp: false,
	magnifyerPos: {x:1000,y:2000}
}

wasDragging = false


lastX = device_mouse_x_to_gui(0)
lastY = device_mouse_y_to_gui(0)
virtualMouse = {x:0,y:0,lx:0,ly:0,tx:-100,ty:-100}
mouseSFactor = 0.5

protractorPos = {x:1400,y:500}

#region Map Vertexes
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_color()
vertex_format_add_texcoord()
format = vertex_format_end();

drawingBuffer = vertex_create_buffer();

magMapTL = {x:0,y:193}
magMapBR = {x:886,y:886}
magMapH = magMapBR.y - magMapTL.y
magMapW = magMapBR.x - magMapTL.x

mapW = 1000
mapH = 1000

mapXMin = 231
mapYMin = 58
mapXMax = mapXMin + mapW
mapYMax = mapYMin + mapH

current_color = c_black

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

function on_interaction_update() {
	var _x = oInputManager.mouse_x_gui
	var _y = oInputManager.mouse_y_gui
	
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
					draw_line_width_color(virtualMouse.lx+state.magnifyerPos.x,virtualMouse.ly+state.magnifyerPos.y,virtualMouse.x+state.magnifyerPos.x,virtualMouse.y+state.magnifyerPos.y,3,current_color,current_color)
				else
					draw_line_width_color(virtualMouse.lx,virtualMouse.ly,virtualMouse.x,virtualMouse.y,7,current_color,current_color)
				
				surface_reset_target()
			}
			window_mouse_set(lastX,lastY)
			virtualMouse.lx = virtualMouse.x
			virtualMouse.ly = virtualMouse.y

			break
			
			
		case "eraser":
			var dX = (_x - lastX) * mouseSFactor
			var dY = (_y - lastY) * mouseSFactor
			
			if state.magnifyerUp{
				dX *= 0.25
				dY *= 0.25
			}
	
			virtualMouse.x += dX * surface_get_width(global.mapSurf) / mapW
			virtualMouse.y += dY * surface_get_height(global.mapSurf) / mapH
			
			virtualMouse.tx += dX
			virtualMouse.ty += dY
			
			
			print(virtualMouse.lx,virtualMouse.ly)

			if surface_exists(global.mapSurf) {
				surface_set_target(global.mapSurf)
				gpu_set_blendmode(bm_subtract)
				//print(virtualMouse, _x, _y)
				if state.magnifyerUp
					draw_line_width_color(virtualMouse.lx+state.magnifyerPos.x,virtualMouse.ly+state.magnifyerPos.y,virtualMouse.x+state.magnifyerPos.x,virtualMouse.y+state.magnifyerPos.y,12,current_color,current_color)
				else
					draw_line_width_color(virtualMouse.lx,virtualMouse.ly,virtualMouse.x,virtualMouse.y,28,current_color,current_color)
				gpu_set_blendmode(bm_normal)
				surface_reset_target()
			}
			window_mouse_set(lastX,lastY)
			virtualMouse.lx = virtualMouse.x
			virtualMouse.ly = virtualMouse.y
			break
	}
}

function interaction_contains_point(x, y) {
    // Custom collision checking (only used if interaction_shape is "custom")
    return mouseInRecBounds({x:mapXMin, y:mapYMin},{x:mapXMax, y:mapYMax});
}

function on_interaction_start() {
	window_set_cursor(cr_none)
    lastX = oInputManager.mouse_x_gui 
	lastY = oInputManager.mouse_y_gui
	virtualMouse.x = (lastX - mapXMin) * surface_get_width(global.mapSurf) / mapW 
	virtualMouse.y = (lastY - mapYMin) * surface_get_height(global.mapSurf) / mapH
	virtualMouse.lx = (lastX - mapXMin) * surface_get_width(global.mapSurf) / mapW 
	virtualMouse.ly = (lastY - mapYMin) * surface_get_height(global.mapSurf) / mapH
	virtualMouse.tx = lastX
	virtualMouse.ty = lastY
}

function on_interaction_end(){
	window_mouse_set(virtualMouse.tx,virtualMouse.ty)
	virtualMouse.tx = -100
	virtualMouse.ty = -100
}
