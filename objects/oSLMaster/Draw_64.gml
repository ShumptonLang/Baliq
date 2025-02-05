if (!surface_exists(screenSurf)){
	screenSurf = surface_create(camera_get_view_width(view_camera[0]),camera_get_view_height(view_camera[0]))
	
}

if (!surface_exists(lidarSurf)){
	lidarSurf = surface_create(camera_get_view_width(view_camera[0]),camera_get_view_height(view_camera[0]))
	
}

//show_debug_message("Master: Starting clear")
	surface_set_target(screenSurf)
	draw_clear_alpha($010101,0)
	surface_reset_target()
//show_debug_message("Master: Finished clear")
	
//show_debug_message("Master: Drawables")
for (var i = 0; i < array_length(drawables);i++){
	if drawables[i].isGui
		drawables[i].drawFunc()	
}


//draw_surface_ext(screenSurf,0,0,1,1,0,c_white,1)

shader_set(CRT)
shader_set_uniform_f(shader_get_uniform(CRT,"u_screenSize"),view_width,view_height)
var tex = surface_get_texture(screenSurf)
vertex_submit(sonarBuffer, pr_trianglefan, tex);
shader_reset()

tex = surface_get_texture(lidarSurf)
vertex_submit(lidarBuffer,pr_trianglefan,tex)

//show_debug_message("Sonar: Starting draw")
if oSonarMaster.scanning || oLidarMaster.scanning {
	draw_sprite_ext(sSonarHud,1+irandom(1),0,0,1,1,0,c_white,1)
} else{
	var shiftGain = audio_sound_get_gain(Groan2)
	draw_sprite_ext(sSonarHud,0,0,0,1,1,shiftGain*5,c_white,1)
}



	

