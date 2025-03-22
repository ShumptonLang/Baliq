




	
//show_debug_message("Master: Drawables")


//draw_surface_ext(screenSurf,0,0,1,1,0,c_white,1)

//draw_sprite(sNuSonarHud,0,0,0)


#region Draw Sonar CRT
if (surface_exists(global.sonarSurf)) {
		
        surface_set_target(global.sonarSurf);
		
		draw_clear_alpha(c_black,0)
		
		if struct_names_count(pointMap) > 0
			vertex_delete_buffer(vBuff);
        vBuff = vertex_create_buffer();
        vertex_begin(vBuff, vertexFormat);
		
		
		for(var i = 0; i < array_length(pointsToRender);i++){
				//print(pointsToRender[i].x)
				vertex_position_3d(vBuff, pointsToRender[i].displayX, pointsToRender[i].displayY,0);
				vertex_color(vBuff, make_color_rgb(pointsToRender[i].lumin,pointsToRender[i].lumin,pointsToRender[i].lumin), 1);
				vertex_texcoord(vBuff, surface_get_width(global.sonarSurf), surface_get_height(global.sonarSurf) )
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
	var tex = surface_get_texture(global.sonarSurf)
	if false
		vertex_submit(oSLMaster.sonarBuffer, pr_trianglefan, tex);
	shader_reset()
#endregion


#region Draw Lidar CRT

//shader_set(CRTLidar)


if keyboard_check(vk_shift){
	draw_sprite_general(mapy,0,ShipMaster.posx-oSLMaster.view_width/2,ShipMaster.posy-oSLMaster.view_height/2,oSLMaster.view_width,oSLMaster.view_height,949,300,0.3,0.3,0,c_white,c_white,c_white,c_white,1)

	draw_surface_general(global.mapSurf,ShipMaster.posx-oSLMaster.view_width/2,ShipMaster.posy-oSLMaster.view_height/2,oSLMaster.view_width,oSLMaster.view_height,949,300,0.3,0.3,0,c_white,c_white,c_white,c_white,1)
	surface_set_target(global.mapSurf)
	draw_clear_alpha(c_blue,0)
	draw_circle(ShipMaster.posx,ShipMaster.posy, 10,0)
	draw_line_width(ShipMaster.posx,ShipMaster.posy,ShipMaster.posx + lengthdir_x(100,ShipMaster.angle),ShipMaster.posy + lengthdir_y(100,ShipMaster.angle),4)
	draw_circle_color(debugTargetPoint.x,debugTargetPoint.y,10,c_blue,c_blue,0)

for (var i = 1; i < array_length(ControllerService.shipStatus.map.navPath); i++) {
	if i == 0
		draw_circle(ControllerService.shipStatus.map.navPath[i].x,ControllerService.shipStatus.map.navPath[i].y,20,0)
	draw_circle(ControllerService.shipStatus.map.navPath[i].x,ControllerService.shipStatus.map.navPath[i].y,5,0)
	draw_line_width(ControllerService.shipStatus.map.navPath[i].x,ControllerService.shipStatus.map.navPath[i].y,ControllerService.shipStatus.map.navPath[i-1].x,ControllerService.shipStatus.map.navPath[i-1].y,3)
}
	surface_reset_target()
}
//shader_reset()

#endregion



//show_debug_message("Sonar: Starting draw")
if !global.debug {
	draw_sprite_ext(sSonarHud,1+irandom(1),0,0,1,1,0,c_white,1)
} else if !global.debug{
	
		draw_sprite_ext(sSonarHud,0,0,0,1,1,0,c_white,1)
	
}


if ControllerService.shipStatus.ship.navigationState == "followingPath"
	draw_text(750,1000,string(pathingError))
	

