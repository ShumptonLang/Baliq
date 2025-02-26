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



lastX = device_mouse_x_to_gui(0)
lastY = device_mouse_y_to_gui(0)
virtualMouse = {x:0,y:0,lx:0,ly:0}
mouseSFactor = 0.5

protractorPos = {x:1400,y:500}

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