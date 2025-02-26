var _x = device_mouse_x_to_gui(0)
var _y = device_mouse_y_to_gui(0)

if global.mouse_occupied_changed and global.mouse_occupied != self and global.mouse_occupied != "mapDrag"{
	
	switch (state.activeTool){
		
		case "pencil":
		if !wasDragging {
			if state.magnifyerUp {
				window_mouse_set(virtualMouse.x + magMapTL.x,virtualMouse.y+magMapTL.y)
			} else {
				window_mouse_set(virtualMouse.x/4 + mapXMin,virtualMouse.y/4+mapYMin)
			}
		
			} else {
				wasDragging = false
		}
		break
		
		case "protractor":
		if state.protractorState == 1 {
			state.protractorDst.x = _x
			state.protractorDst.y = _y
		}
		
		if state.protractorState == 2 {
			state.protractorDst2.x = _x
			state.protractorDst2.y = _y
		}
		
		state.protractorState = (state.protractorState + 1)%4
		
		if state.protractorState == 0 {
			state.protractorDrawing = false
		}
		
		if state.protractorState == 3{
			surface_set_target(global.mapSurf)
			if !state.magnifyerUp{
				draw_set_alpha(0.5)
				draw_line_width_color((state.protractorSrc.x-mapXMin)*4,(state.protractorSrc.y-mapYMin)*4,(state.protractorDst.x-mapXMin)*4,(state.protractorDst.y-mapYMin)*4,12,c_dkgray,c_dkgray)
				draw_line_width_color((state.protractorSrc.x-mapXMin)*4,(state.protractorSrc.y-mapYMin)*4,(state.protractorDst2.x-mapXMin)*4,(state.protractorDst2.y-mapYMin)*4,8,c_dkgray,c_dkgray)
							//print("SC",point_direction(state.protractorSrc.x,state.protractorSrc.y,state.protractorDst.x,state.protractorDst.y))
				draw_set_alpha(1)
				draw_text_transformed_colour((state.protractorDst.x-mapXMin)*4,(state.protractorDst2.y-mapYMin)*4,string(abs(point_direction(state.protractorSrc.x,state.protractorSrc.y,state.protractorDst2.x,state.protractorDst2.y)-point_direction(state.protractorSrc.x,state.protractorSrc.y,state.protractorDst.x,state.protractorDst.y))),5,4,irandom(30)-15,c_black,c_blue,c_black,c_blue,0.5)
		
			} else {
				draw_set_alpha(0.5)
				draw_line_width_color((state.protractorSrc.x-magMapTL.x+state.magnifyerPos.x),(state.protractorSrc.y-magMapTL.y+state.magnifyerPos.y),(state.protractorDst.x-magMapTL.x+state.magnifyerPos.x),(state.protractorDst.y-magMapTL.y+state.magnifyerPos.y),3,c_dkgray,c_dkgray)
				draw_line_width_color((state.protractorSrc.x-magMapTL.x+state.magnifyerPos.x),(state.protractorSrc.y-magMapTL.y+state.magnifyerPos.y),(state.protractorDst2.x-magMapTL.x+state.magnifyerPos.x),(state.protractorDst2.y-magMapTL.y+state.magnifyerPos.y),2,c_dkgray,c_dkgray)
							//print("SC",point_direction(state.protractorSrc.x,state.protractorSrc.y,state.protractorDst.x,state.protractorDst.y))
				draw_set_alpha(1)
				draw_text_transformed_colour((state.protractorDst.x-magMapTL.x+state.magnifyerPos.x),(state.protractorDst2.y-magMapTL.y+state.magnifyerPos.y),string(abs(point_direction(state.protractorSrc.x,state.protractorSrc.y,state.protractorDst2.x,state.protractorDst2.y)-point_direction(state.protractorSrc.x,state.protractorSrc.y,state.protractorDst.x,state.protractorDst.y))),2.5,2,irandom(30)-15,c_black,c_blue,c_black,c_blue,0.5)
			
			}
		surface_reset_target()
		}
		break
		
	}
}