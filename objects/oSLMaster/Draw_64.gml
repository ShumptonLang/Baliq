if (!surface_exists(screenSurf)){
	screenSurf = surface_create(camera_get_view_width(view_camera[0]),camera_get_view_height(view_camera[0]))
	
}

if (!surface_exists(lidarSurf)){
	lidarSurf = surface_create(camera_get_view_width(view_camera[0]),camera_get_view_height(view_camera[0]))
	
}

//show_debug_message("Master: Starting clear")
	surface_set_target(screenSurf)
	draw_clear_alpha(c_black,0)
	surface_reset_target()
//show_debug_message("Master: Finished clear")
	
//show_debug_message("Master: Drawables")
for (var i = 0; i < array_length(drawables);i++){
	if drawables[i].isGui
		drawables[i].drawFunc()	
}


//draw_surface_ext(screenSurf,0,0,1,1,0,c_white,1)

shader_set(CRT)
shader_set_uniform_f(shader_get_uniform(CRT,"u_radControl"),device_mouse_x_to_gui(0)/window_get_width()*5)
var tex = surface_get_texture(screenSurf)
vertex_submit(sonarBuffer, pr_trianglefan, tex);
shader_reset()

shader_set(CRTLidar)
var samp = shader_get_sampler_index(CRTLidar,"u_GlassTex")
texture_set_stage(samp,sprite_get_texture(SpecularMap,0))
tex = surface_get_texture(lidarSurf)
vertex_submit(lidarBuffer,pr_trianglefan,tex)
shader_reset()

//show_debug_message("Sonar: Starting draw")
if oSonarMaster.scanning || oLidarMaster.scanning || fmod_studio_event_instance_get_playback_state(oLidarMaster.eventLidarEngagedI) == FMOD_STUDIO_PLAYBACK_STATE.PLAYING {
	draw_sprite_ext(sSonarHud,1+irandom(1),0,0,1,1,0,c_white,1)
} else{
	
		draw_sprite_ext(sSonarHud,0,0,0,1,1,0,c_white,1)
	
}



	

