draw_sprite_ext(sMapMagnifyer,0,50 + ShipMaster.shipStatus.map.magnifyerUp*1000,440,1.15,1.15,0,c_white,1)

if ShipMaster.shipStatus.map.magnifyerUp{
	draw_sprite_part_ext(mapy,0,ShipMaster.shipStatus.map.magnifyerPos.x,ShipMaster.shipStatus.map.magnifyerPos.y,magMapW,magMapH,magMapTL.x,magMapTL.y,1,1,c_white,1)
	draw_surface_part(global.mapSurf,ShipMaster.shipStatus.map.magnifyerPos.x,ShipMaster.shipStatus.map.magnifyerPos.y,magMapW,magMapH,magMapTL.x,magMapTL.y)
}