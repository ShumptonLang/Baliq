draw_sprite(sMapRoom,0,0,0)

draw_sprite_ext(mapy,0,mapXMin,mapYMin,mapW/sprite_get_width(mapy),mapH/sprite_get_height(mapy),0,c_white,1)

var tex = surface_get_texture(global.mapSurf)
vertex_submit(drawingBuffer,pr_trianglefan,tex)
draw_sprite_ext(sMapMagnifyer,0,50 + state.magnifyerUp*1000,440,1.15,1.15,0,c_white,1)
if state.magnifyerUp{
	draw_sprite_part(mapy,0,state.magnifyerPos.x - 443,state.magnifyerPos.y - 346,886,693,0,193)
	draw_surface_part(global.mapSurf,state.magnifyerPos.x - 443,state.magnifyerPos.y - 346,886,693,0,193)
}

var _x = device_mouse_raw_x(0)
var _y = device_mouse_raw_y(0)

print(_x,_y)
switch(state.activeTool){
	
	case "protractor":
		if state.protractorDrawing{
			switch (state.protractorState){
				case 1:
					draw_line_width_color(state.protractorSrc.x,state.protractorSrc.y,_x,_y,2,c_dkgray,c_dkgray)
					break
				case 2 :
					draw_line_width_color(state.protractorSrc.x,state.protractorSrc.y,state.protractorDst.x,state.protractorDst.y,2,c_dkgray,c_dkgray)
					draw_line_width_color(state.protractorSrc.x,state.protractorSrc.y,_x,_y,2,c_dkgray,c_dkgray)
					//print("SC",point_direction(state.protractorSrc.x,state.protractorSrc.y,state.protractorDst.x,state.protractorDst.y))
					//abs(point_direction(state.protractorSrc.x,state.protractorSrc.y,_x,_y)-point_direction(state.protractorSrc.x,state.protractorSrc.y,state.protractorDst.x,state.protractorDst.y))
					draw_text_color(state.protractorDst.x,_y,string(abs(point_direction(state.protractorSrc.x,state.protractorSrc.y,_x,_y)-point_direction(state.protractorSrc.x,state.protractorSrc.y,state.protractorDst.x,state.protractorDst.y))),c_black,c_blue,c_black,c_blue,0.5)
					break
				case 3 :
					draw_line_width_color(state.protractorSrc.x,state.protractorSrc.y,state.protractorDst.x,state.protractorDst.y,2,c_dkgray,c_dkgray)
					draw_line_width_color(state.protractorSrc.x,state.protractorSrc.y,state.protractorDst2.x,state.protractorDst2.y,2,c_dkgray,c_dkgray)
					//print("SC",point_direction(state.protractorSrc.x,state.protractorSrc.y,state.protractorDst.x,state.protractorDst.y))
					draw_text_color(state.protractorDst.x,state.protractorDst2.y,string(abs(point_direction(state.protractorSrc.x,state.protractorSrc.y,state.protractorDst2.x,state.protractorDst2.y)-point_direction(state.protractorSrc.x,state.protractorSrc.y,state.protractorDst.x,state.protractorDst.y))),c_black,c_blue,c_black,c_blue,0.5)
					break
			}
		}
		draw_sprite_ext(sProtractor,0,_x,_y,2,2,0,c_black,0.3)
		draw_sprite_ext(sProtractor,0,protractorPos.x,protractorPos.y,2,2,0,c_black,0.3)
		break
	
	case "pencil":
		draw_sprite_ext(sProtractor,0,protractorPos.x,protractorPos.y,2,2,0,c_white,0.9)
		break
}