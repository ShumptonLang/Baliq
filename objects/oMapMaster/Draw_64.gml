draw_sprite(sMapRoom,0,0,0)

draw_sprite_ext(mapy,0,currMapX,currMapY,mapW/sprite_get_width(mapy),mapH/sprite_get_height(mapy),0,c_white,1)

surface_set_target(global.mapSurf)
draw_set_color(c_black)

if keyboard_check_pressed(vk_control){
	draw_clear_alpha(c_black,0)	
}

draw_circle(ShipMaster.posx,ShipMaster.posy, 10,0)
draw_line_width(ShipMaster.posx,ShipMaster.posy,ShipMaster.posx + lengthdir_x(100,ShipMaster.angle),ShipMaster.posy + lengthdir_y(100,ShipMaster.angle),4)


for (var i = 1; i < array_length(ControllerService.shipStatus.map.navPath); i++) {
	if i == 0
		draw_circle(ControllerService.shipStatus.map.navPath[i].x,ControllerService.shipStatus.map.navPath[i].y,20,0)
	draw_circle(ControllerService.shipStatus.map.navPath[i].x,ControllerService.shipStatus.map.navPath[i].y,5,0)
	draw_line_width(ControllerService.shipStatus.map.navPath[i].x,ControllerService.shipStatus.map.navPath[i].y,ControllerService.shipStatus.map.navPath[i-1].x,ControllerService.shipStatus.map.navPath[i-1].y,3)
}


surface_reset_target()
if ControllerService.shipStatus.map.stateMachine.currentState.name == "scanScan"
	draw_sprite(sPrinterHead,irandom(1),0,0)
else
	draw_sprite(sPrinterHead,0,0,0)

#region Map Vertexes

var mapXMin = currMapX
var mapYMin = currMapY
var mapXMax = mapXMin + mapW
var mapYMax = mapYMin + mapH

var drawingBuffer = vertex_create_buffer();

vertex_begin(drawingBuffer,format);

vertex_position_3d(drawingBuffer,   mapXMin, mapYMin, 0); vertex_color(drawingBuffer, c_white, 1); vertex_texcoord(drawingBuffer, 0,0)
vertex_position_3d(drawingBuffer,   mapXMax, mapYMin, 0); vertex_color(drawingBuffer, c_white, 1); vertex_texcoord(drawingBuffer, 1,0);
vertex_position_3d(drawingBuffer,   mapXMax, mapYMax, 0); vertex_color(drawingBuffer, c_white, 1); vertex_texcoord(drawingBuffer, 1, 1);
vertex_position_3d(drawingBuffer,	mapXMin, mapYMax, 0); vertex_color(drawingBuffer, c_white, 1); vertex_texcoord(drawingBuffer, 0, 1);

vertex_position_3d(drawingBuffer,   mapXMin, mapYMin, 0); vertex_color(drawingBuffer, c_white, 1); vertex_texcoord(drawingBuffer, 0,0)

vertex_end(drawingBuffer)
#endregion


var tex = surface_get_texture(global.mapSurf)
vertex_submit(drawingBuffer,pr_trianglefan,tex)





//print(_x,_y)