buffer = global.currMapBuffer
noiseB = global.noiseBuffer

lineNoise = sprite_get_texture(funkyNoise,0)



pointMap = {}
chunkSize = 100

lastHistLength = 0
pointsToRender = array_create(0)

isGui = true
debugg_mode = 0

vBuff = vertex_create_buffer()
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_color()
vertex_format_add_texcoord()
vertex_format_add_texcoord()
vertexFormat = vertex_format_end();


//Handles vBuffer, not a traditional Draw
drawFunc = function(){
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
				var noiseOffset = getPixelFromBuffer(noiseB,pointsToRender[i].noiseX * 20 +timeScale, pointsToRender[i].noiseY * 20 + timeScale)
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
}

function updateStatus(buttonid, buttonStatus){
		
        
        // Only loop through points within view
        
}

	
