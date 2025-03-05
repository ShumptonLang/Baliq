draw_sprite(sMapRoom,0,0,0)

draw_sprite_ext(mapy,0,mapXMin,mapYMin,mapW/sprite_get_width(mapy),mapH/sprite_get_height(mapy),0,c_white,1)


var tex = surface_get_texture(global.mapSurf)
vertex_submit(drawingBuffer,pr_trianglefan,tex)



draw_set_color(c_black)
if state.activeTool == "eraser"
	draw_circle(virtualMouse.tx,virtualMouse.ty,7,1)
draw_set_color(c_white)

//print(_x,_y)