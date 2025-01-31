buffer = global.currMapBuffer
shadowSurf = oSLMaster.shadowSurf

white = {
	r: 255,
	g: 255,
	b: 255,
	a: 255
}

hist = array_create(0)
floor_hist = array_create(0)

isGui = true
drawFunc = function(){
	if (surface_exists(oSLMaster.screenSurf)){
		surface_set_target(oSLMaster.screenSurf)
		vertex_begin(oSLMaster.vBuff,oSLMaster.vertexFormat)

		draw_set_color(c_white)
		for (var i=0; i< array_length(hist)-1; i++){

			var dist = 1/(point_distance(hist[i].tempX, hist[i].tempY,hist[i+1].tempX,hist[i+1].tempY))
			
			hist[i].tempX += random_range(-1,1) * (1-hist[i].noiseFactor)
			hist[i].tempX = clamp(hist[i].tempX,hist[i].x - 5,hist[i].x+5)
			hist[i].tempY += random_range(-1,1) * (1-hist[i].noiseFactor)
			hist[i].tempY = clamp(hist[i].tempY,hist[i].y - 5,hist[i].y+5)
	
			var _x = random_range(-maxDrift,maxDrift) * (1 - hist[i].noiseFactor)
			var _y = random_range(-maxDrift,maxDrift) * (1 - hist[i].noiseFactor)

			//draw_sprite(Blip,0,hist[i].tempX+_x,hist[i].tempY+_y)	
			//draw_set_alpha(5/(point_distance(hist[i].tempX, hist[i].tempY,hist[i+1].tempX,hist[i+1].tempY)))
			var screenSrc = relativePos(hist[i].tempX, hist[i].tempY)
			var screenDst = relativePos(hist[i+1].tempX, hist[i+1].tempY)
			//draw_line(screenSrc.x, screenSrc.y,screenDst.x,screenDst.y)
			vertex_position(oSLMaster.vBuff, screenSrc.x,screenSrc.y)
			vertex_color(oSLMaster.vBuff,c_white,dist)
			


		
		
		
		
	}
	draw_set_alpha(1)
	surface_reset_target()
	vertex_end(oSLMaster.vBuff)
	}
}
