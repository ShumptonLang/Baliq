buffer = global.currMapBuffer
lineNoise = sprite_get_texture(fakeNoise,0)
if (lineNoise == -1) {
    show_debug_message("Failed to load noise texture!");
}

white = {
	r: 255,
	g: 255,
	b: 255,
	a: 255
}

hist = array_create(0)
lastHistLength = 0
floor_hist = array_create(0)

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
		
		if lastHistLength != array_length(hist){
			updateVBuffer()
			lastHistLength = array_length(hist)
		}

		shader_set(SonarLines);
		var tex_uniform = shader_get_sampler_index(SonarLines, "u_NoiseTex");
		gpu_set_texrepeat(true)
		texture_set_stage(tex_uniform, lineNoise);
		shader_set_uniform_f(shader_get_uniform(SonarLines, "u_Time"), current_time);
		show_debug_message("Texture Stage: " + string(tex_uniform));
		show_debug_message("Noise Texture: " + string(lineNoise));
		
		if keyboard_check_pressed(vk_space) {
			debugg_mode = (debugg_mode + 1) mod 4;
			
			}
		
		shader_set_uniform_f(shader_get_uniform(SonarLines, "u_Debug"), keyboard_check(vk_space));
		print(debugg_mode)
		
		

		//print(shader_get_uniform(SonarLines, "u_NoiseTex"),lineNoise)

		if lastHistLength > 0
			vertex_submit(vBuff, pr_linestrip, -1);
		shader_reset();
        surface_reset_target();
    }
}

function updateVBuffer(){
		if lastHistLength > 0
			vertex_delete_buffer(vBuff);
        vBuff = vertex_create_buffer();
        vertex_begin(vBuff, vertexFormat);
        
        // Only loop through points within view
        for (var i = 1; i < array_length(hist)-1; i++) {
            if (point_distance(ShipMaster.posx, ShipMaster.posy, hist[i].x, hist[i].y) < 300) {
				var distTo = 9/(point_distance(hist[i].tempX, hist[i].tempY,hist[i+1].tempX,hist[i+1].tempY))
				var distFrom = 9/(point_distance(hist[i].tempX, hist[i].tempY,hist[i-1].tempX,hist[i-1].tempY))
				var dist = min(distTo,distFrom)
                var screenSrc = screenPos(hist[i].tempX, hist[i].tempY);
                
                vertex_position_3d(vBuff, screenSrc.x, screenSrc.y,0);
                vertex_color(vBuff, c_white, dist);
				vertex_texcoord(vBuff, oSLMaster.view_width , oSLMaster.view_height )
				vertex_texcoord(vBuff, random(1),random(1))
				
            }
        }
        
        vertex_end(vBuff);
}
