if state.activeTool == "protractor"{
	state.activeTool = "pencil"
	if state.protractorState == 3{
		surface_set_target(global.mapSurf)
		draw_line_width_color(state.protractorSrc.x-mapXMin,state.protractorSrc.y-mapYMin,state.protractorDst.x-mapXMin,state.protractorDst.y-mapYMin,2,c_dkgray,c_dkgray)
		draw_line_width_color(state.protractorSrc.x-mapXMin,state.protractorSrc.y-mapYMin,state.protractorDst2.x-mapXMin,state.protractorDst2.y-mapYMin,2,c_dkgray,c_dkgray)
					//print("SC",point_direction(state.protractorSrc.x,state.protractorSrc.y,state.protractorDst.x,state.protractorDst.y))
		draw_text_color(state.protractorDst.x-mapXMin,state.protractorDst2.y-mapYMin,string(abs(point_direction(state.protractorSrc.x,state.protractorSrc.y,state.protractorDst2.x,state.protractorDst2.y)-point_direction(state.protractorSrc.x,state.protractorSrc.y,state.protractorDst.x,state.protractorDst.y))),c_black,c_blue,c_black,c_blue,0.5)
		surface_reset_target()
	}
	state.protractorState = 0
	state.protractorDrawing = false
}
else
	room_goto(Sonar)