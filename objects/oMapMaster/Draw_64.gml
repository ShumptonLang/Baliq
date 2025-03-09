draw_sprite(sMapRoom,0,0,0)

draw_sprite_ext(mapy,0,mapXMin,mapYMin,mapW/sprite_get_width(mapy),mapH/sprite_get_height(mapy),0,c_white,1)

surface_set_target(global.mapSurf)
draw_set_color(c_black)

if keyboard_check_pressed(vk_control){
	draw_clear_alpha(c_black,0)	
}

draw_circle(ShipMaster.posx,ShipMaster.posy, 10,0)
draw_line_width(ShipMaster.posx,ShipMaster.posy,ShipMaster.posx + lengthdir_x(100,ShipMaster.angle),ShipMaster.posy + lengthdir_y(100,ShipMaster.angle),4)


for (var i = 1; i < array_length(navPath); i++) {
	if i == 0
		draw_circle(navPath[i].x,navPath[i].y,20,0)
	draw_circle(navPath[i].x,navPath[i].y,5,0)
	draw_line_width(navPath[i].x,navPath[i].y,navPath[i-1].x,navPath[i-1].y,3)
}
surface_reset_target()


var tex = surface_get_texture(global.mapSurf)
vertex_submit(drawingBuffer,pr_trianglefan,tex)





//print(_x,_y)