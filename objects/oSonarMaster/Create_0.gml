buffer = global.currMapBuffer
noiseB = global.noiseBuffer

lineNoise = sprite_get_texture(funkyNoise,0)

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
		
		if lastHistLength > 0
			vertex_delete_buffer(vBuff);
        vBuff = vertex_create_buffer();
        vertex_begin(vBuff, vertexFormat);
		for (var i = 2; i < array_length(hist)-2; i++) {
            if (point_distance(ShipMaster.posx, ShipMaster.posy, hist[i].x, hist[i].y) < 300) {
				var distTo = min(10/(point_distance(hist[i].tempX, hist[i].tempY,hist[i+2].tempX,hist[i+2].tempY)),1)+0.1
				var distFrom = min(10/(point_distance(hist[i].tempX, hist[i].tempY,hist[i-2].tempX,hist[i-2].tempY)),1)+0.1
				var dist = min(distTo,distFrom)*0.9
                var screenSrc = screenPos(hist[i].tempX, hist[i].tempY);
                
				uvs = sprite_get_uvs(fakeNoise,0)
				
                vertex_position_3d(vBuff, screenSrc.x, screenSrc.y,0);
                vertex_color(vBuff, c_white, dist);
				vertex_texcoord(vBuff, oSLMaster.view_width , oSLMaster.view_height )
				var timeScale = current_time / 100
				var noiseOffset = getPixelFromBuffer(noiseB,hist[i].noiseX * 20 +timeScale, hist[i].noiseY * 20 + timeScale,256,256)
				
				vertex_texcoord(vBuff,noiseOffset.r,(noiseOffset.g))  
				
            }
        }
        
        vertex_end(vBuff);
		lastHistLength = array_length(hist)
		shader_set(SonarLines);
		shader_set_uniform_f(shader_get_uniform(SonarLines, "u_Time"), current_time);
		shader_set_uniform_f(shader_get_uniform(SonarLines, "u_Debug"), keyboard_check(vk_space));
		var texIndex = shader_get_sampler_index(SonarLines,"u_NoiseTex")
		texture_set_stage(texIndex, lineNoise)
		
		

		//print(shader_get_uniform(SonarLines, "u_NoiseTex"),lineNoise)

		if lastHistLength > 0
			vertex_submit(vBuff, pr_linestrip, -1);
		shader_reset();
        surface_reset_target();
    }
}

function updateVBuffer(){
		
        
        // Only loop through points within view
        
}
