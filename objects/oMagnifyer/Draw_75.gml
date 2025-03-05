draw_sprite_ext(sMapMagnifyer,0,50 + oMapMaster.state.magnifyerUp*1000,440,1.15,1.15,0,c_white,1)

if oMapMaster.state.magnifyerUp{
	draw_sprite_part_ext(mapy,0,oMapMaster.state.magnifyerPos.x,oMapMaster.state.magnifyerPos.y,magMapW,magMapH,magMapTL.x,magMapTL.y,1,1,c_white,1)
	draw_surface_part(global.mapSurf,oMapMaster.state.magnifyerPos.x,oMapMaster.state.magnifyerPos.y,magMapW,magMapH,magMapTL.x,magMapTL.y)
}