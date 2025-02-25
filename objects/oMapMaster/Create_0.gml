state = {
	pencilUp: false,
	protractorUp: false
}

vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_color()
vertex_format_add_texcoord()
format = vertex_format_end();

drawingBuffer = vertex_create_buffer();




vertex_begin(drawingBuffer,format);

vertex_position_3d(drawingBuffer,   231,58, 0); vertex_color(drawingBuffer, c_white, 1); vertex_texcoord(drawingBuffer, 0,0)
vertex_position_3d(drawingBuffer,   231,1016, 0); vertex_color(drawingBuffer, c_white, 1); vertex_texcoord(drawingBuffer, 0,1);
vertex_position_3d(drawingBuffer, 1194, 58, 0); vertex_color(drawingBuffer, c_white, 1); vertex_texcoord(drawingBuffer, 1, 0);
vertex_position_3d(drawingBuffer,   1194, 1016, 0); vertex_color(drawingBuffer, c_white, 1); vertex_texcoord(drawingBuffer, 1, 1);

vertex_end(drawingBuffer)
