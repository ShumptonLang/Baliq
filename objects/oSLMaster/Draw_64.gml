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


#region Draw Sonar CRT
if (surface_exists(oSLMaster.screenSurf)) {
		
        surface_set_target(oSLMaster.screenSurf);
		
		if struct_names_count(pointMap) > 0
			vertex_delete_buffer(vBuff);
        vBuff = vertex_create_buffer();
        vertex_begin(vBuff, vertexFormat);
		
		
		for(var i = 0; i < array_length(pointsToRender);i++){
				//print(pointsToRender[i].x)
				vertex_position_3d(vBuff, pointsToRender[i].displayX, pointsToRender[i].displayY,0);
				vertex_color(vBuff, make_color_rgb(pointsToRender[i].lumin,pointsToRender[i].lumin,pointsToRender[i].lumin), 1);
				vertex_texcoord(vBuff, oSLMaster.view_width , oSLMaster.view_height )
				var timeScale = current_time / 100
				var noiseOffset = getPixelFromBuffer(global.noiseBuffer,pointsToRender[i].noiseX * 20 +timeScale, pointsToRender[i].noiseY * 20 + timeScale)
				vertex_texcoord(vBuff,noiseOffset.r,(noiseOffset.g))
				
		}
	
        
        vertex_end(vBuff);

		shader_set(SonarLines);
		shader_set_uniform_f(shader_get_uniform(SonarLines, "u_Time"), current_time);
		shader_set_uniform_f(shader_get_uniform(SonarLines, "u_Debug"), keyboard_check(vk_space));
		var texIndex = shader_get_sampler_index(SonarLines,"u_NoiseTex")
		texture_set_stage(texIndex, lineNoise)
		
		

		//print(shader_get_uniform(SonarLines, "u_NoiseTex"),lineNoise)

		if struct_names_count(pointMap) > 0
			vertex_submit(vBuff, pr_linestrip, -1);
		shader_reset();
		draw_set_color(c_white)
		//draw_circle(720,540,30,1)
        surface_reset_target();
		pointsToRender = array_create(0)
    }
	
	shader_set(CRT)
	shader_set_uniform_f(shader_get_uniform(CRT,"u_radControl"),device_mouse_x_to_gui(0)/window_get_width()*5)
	var tex = surface_get_texture(oSLMaster.screenSurf)
	vertex_submit(oSLMaster.sonarBuffer, pr_trianglefan, tex);
	shader_reset()
#endregion


shader_set(CRTLidar)
var samp = shader_get_sampler_index(CRTLidar,"u_GlassTex")
texture_set_stage(samp,sprite_get_texture(SpecularMap,0))
tex = surface_get_texture(lidarSurf)
vertex_submit(lidarBuffer,pr_trianglefan,tex)
shader_reset()



//show_debug_message("Sonar: Starting draw")
if oLidarMaster.scanning || fmod_studio_event_instance_get_playback_state(oLidarMaster.eventLidarEngagedI) == FMOD_STUDIO_PLAYBACK_STATE.PLAYING {
	draw_sprite_ext(sSonarHud,1+irandom(1),0,0,1,1,0,c_white,1)
} else{
	
		draw_sprite_ext(sSonarHud,0,0,0,1,1,0,c_white,1)
	
}



	

