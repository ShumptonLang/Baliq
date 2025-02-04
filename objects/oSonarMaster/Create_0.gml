buffer = global.currMapBuffer
noiseB = global.noiseBuffer

lineNoise = sprite_get_texture(funkyNoise,0)

white = {
	r: 255,
	g: 255,
	b: 255,
	a: 255
}

randomErrors = array_create(0)
hHist = ds_map_create()
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
		var mapPointX = round(ShipMaster.posx / 100)*100
		var mapPointY = round(ShipMaster.posy / 100)*100
		//Range of hashmap lookup, ex. 4 = -200,200
		
	
		var lookupRange = 4
		for (var i = 0; i < 2*lookupRange+1; i++) {
			for (var j = 0; j < 2*lookupRange+1; j++){
				if random(1) < 0.0001 {
					var xDom= irandom(1)
					var errorX = irandom(1)
					var errorY = irandom(1)
					if xDom
						errorX *= oSLMaster.view_width * random(1)
					else
						errorY *= oSLMaster.view_height * random(1)
					var error = worldPos(errorX,errorY)
					array_insert(randomErrors,0,error)
					print(error)
					
				}
				var cellPos = string((i-lookupRange)*100 + mapPointX) + "." + string((j-lookupRange)*100 + mapPointY)
				
				var cellArray = ds_map_find_value(hHist,cellPos)
				
				
				for( var k = 0; k < array_length(cellArray); k++){

					var screenSrc = screenPos(cellArray[k].tempX, cellArray[k].tempY);

				
					var normPos = normalizeToCenter(screenSrc)

				

					var distShip = sqr(min(29/(point_distance(cellArray[k].tempX, cellArray[k].tempY,ShipMaster.posx,ShipMaster.posy)),1))*2.8
				//print(dist, ":", distShip)
					var dist = distShip
				
				
				
					vertex_position_3d(vBuff, normPos.x, normPos.y,0);
					vertex_color(vBuff, c_white, dist);
					vertex_texcoord(vBuff, oSLMaster.view_width , oSLMaster.view_height )
					var timeScale = current_time / 100
					var noiseOffset = getPixelFromBuffer(noiseB,cellArray[k].noiseX * 20 +timeScale, cellArray[k].noiseY * 20 + timeScale,256,256)
				
					vertex_texcoord(vBuff,noiseOffset.r,(noiseOffset.g))  
					
					for (var l = 0; l < array_length(randomErrors);l++){
					screenSrc = screenPos(randomErrors[l].x,randomErrors[l].y)
					vertex_position_3d(vBuff, screenSrc.x, screenSrc.y,0);
					vertex_color(vBuff, c_white, 1);
					vertex_texcoord(vBuff, oSLMaster.view_width , oSLMaster.view_height )
					vertex_texcoord(vBuff,0,0)
					}
				}	
            }
        }
        
        vertex_end(vBuff);

		lastHistLength = ds_map_size(hHist)
		shader_set(SonarLines);
		shader_set_uniform_f(shader_get_uniform(SonarLines, "u_Time"), current_time);
		shader_set_uniform_f(shader_get_uniform(SonarLines, "u_Debug"), keyboard_check(vk_space));
		var texIndex = shader_get_sampler_index(SonarLines,"u_NoiseTex")
		texture_set_stage(texIndex, lineNoise)
		
		

		//print(shader_get_uniform(SonarLines, "u_NoiseTex"),lineNoise)

		if lastHistLength > 0
			vertex_submit(vBuff, pr_linestrip, -1);
		shader_reset();
		draw_set_color(c_white)
		//draw_circle(720,540,30,1)
        surface_reset_target();
    }
}

function updateVBuffer(){
		
        
        // Only loop through points within view
        
}
