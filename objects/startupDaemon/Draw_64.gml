var vidFrame = video_draw()

if vidFrame[0] == 0 {
	var vidScale = (display_get_height()/2160)/1.33
	//print(display_get_height())
	draw_surface_ext(vidFrame[1],0,0,vidScale,vidScale,0,c_white,1)
	
}
