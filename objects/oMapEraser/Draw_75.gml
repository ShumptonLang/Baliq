

if ShipMaster.shipStatus.map.activeTool == "eraser" {
	draw_sprite_ext(sEraser,0,x,y,1,1,0,c_black,0.3)	
} else {
	draw_self()
}