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
chunkSize = 500

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
		var mapPointX = round(ShipMaster.posx / chunkSize)*chunkSize
		var mapPointY = round(ShipMaster.posy / chunkSize)*chunkSize
		//Range of hashmap lookup, ex. 4 = -200,200
		
	
		var lookupRange = 2
		for (var i = 0; i < 2*lookupRange+1; i++) {
			for (var j = 0; j < 2*lookupRange+1; j++){
				
				var cellPos = string((i-lookupRange)*chunkSize + mapPointX) + "." + string((j-lookupRange)*chunkSize + mapPointY)
				
				var cellArray = ds_map_find_value(hHist,cellPos)
				
				
				
				
				for( var k = 1; k < array_length(cellArray)-1; k++){
					
					
					if random(10) < 0.00002 {
					var xDom= irandom(1)
					var errorX = 0
					var errorY = 0
					if xDom {
						errorX = oSLMaster.view_width * random(1) * 0.5 + 360
						errorY = oSLMaster.view_height * irandom(1) * 0.5 + 270
					}
					else {
						errorY = oSLMaster.view_height * random(1) * 0.5 + 270
						errorX = oSLMaster.view_width * irandom(1) * 0.5 + 360
					}
					var error = {x:errorX,y:errorY,i:i,j:j,k:k,life:50000}
					array_insert(randomErrors,0,error)
					print(error)
					
					}
				
					
					for (var l = 0; l < array_length(randomErrors);l++){
						if(randomErrors[l].i == i and randomErrors[l].j == j and randomErrors[l].k == k and randomErrors[l].life > 0){
							vertex_position_3d(vBuff, randomErrors[l].x, randomErrors[l].y,0);
							vertex_color(vBuff, c_white, 0.1);
							vertex_texcoord(vBuff, oSLMaster.view_width , oSLMaster.view_height )
							vertex_texcoord(vBuff,0,0)
						}
						randomErrors[l].life--
					}

					var screenSrc = screenPos(cellArray[k].tempX, cellArray[k].tempY);

				
					var normPos = normalizeToCenter(screenSrc)
					var angle = point_direction(720,540,normPos.x,normPos.y) +ShipMaster.angle

					//print(normPos)
					normPos = screen2clip(normPos.x,normPos.y)
					//print(normPos)
					
					var siltImpact = cellArray[k].material.g / 255
					
					var warpMin = 1 - siltImpact/10
					var warpMax = 1 + siltImpact/10
					
					
					var warpMult = (warpMax-warpMin)
					
					normPos.x *= warpMult * (dsin(5*angle+current_time/10)/2) + warpMin
					normPos.y *= warpMult * (dsin(5*angle+current_time/20)/2) + warpMin
					
					warpMin = 1 - siltImpact/20
					warpMax = 1 + siltImpact/15

					warpMult = (warpMax-warpMin)
					
					normPos.x *= warpMult * (dsin(20*angle-current_time/30)/2) + warpMin
					normPos.y *= warpMult * (dsin(20*angle-current_time/10)/2) + warpMin
					
					var warpColor = ((1-abs(dcos(5*angle+current_time/100)))*5)
					warpColor = max(warpColor,0)

					
					//normPos.x *= random_range(0.9,1.1)
					//normPos.y *= random_range(0.9,1.1)
					//print(normPos)
					normPos = clip2screen(normPos.x,normPos.y)
					//print(normPos)
					var distTo = 255/(point_distance(cellArray[k].tempX, cellArray[k].tempY,cellArray[k+1].tempX,cellArray[k+1].tempY))*10
					var distFrom = 255/(point_distance(cellArray[k].tempX, cellArray[k].tempY,cellArray[k-1].tempX,cellArray[k-1].tempY))*10
					var dist = min(min(distTo,distFrom),0)
					var distShip = 255/power(point_distance(cellArray[k].tempX, cellArray[k].tempY,ShipMaster.posx,ShipMaster.posy),3)*50000
					dist = distShip+warpColor
				//print(dist, ":", distShip)
				
				
				
					vertex_position_3d(vBuff, normPos.x, normPos.y,0);
					vertex_color(vBuff, make_color_rgb(dist,dist,dist), 1);
					vertex_texcoord(vBuff, oSLMaster.view_width , oSLMaster.view_height )
					var timeScale = current_time / 100
					var noiseOffset = getPixelFromBuffer(noiseB,cellArray[k].noiseX * 20 +timeScale, cellArray[k].noiseY * 20 + timeScale)
				
					vertex_texcoord(vBuff,noiseOffset.r,(noiseOffset.g))  
					
					
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
