draw_sprite(sMapRoom,0,0,0)

draw_sprite_ext(mapy,0,mapXMin,mapYMin,mapW/sprite_get_width(mapy),mapH/sprite_get_height(mapy),0,c_white,1)


var tex = surface_get_texture(global.mapSurf)
vertex_submit(drawingBuffer,pr_trianglefan,tex)
draw_sprite_ext(sMapMagnifyer,0,50 + state.magnifyerUp*1000,440,1.15,1.15,0,c_white,1)
if state.magnifyerUp{
	draw_sprite_part_ext(mapy,0,state.magnifyerPos.x,state.magnifyerPos.y,magMapW,magMapH,magMapTL.x,magMapTL.y,1,1,c_white,1)
	draw_surface_part(global.mapSurf,state.magnifyerPos.x,state.magnifyerPos.y,magMapW,magMapH,magMapTL.x,magMapTL.y)
}

draw_set_color(c_black)
if state.activeTool == "eraser"
	draw_circle(virtualMouse.tx,virtualMouse.ty,7,1)
draw_set_color(c_white)

//print(_x,_y)