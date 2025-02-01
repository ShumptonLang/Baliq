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
	if surface_exists(oSLMaster.screenSurf){
	surface_set_target(oSLMaster.screenSurf)
	

	for (var i=0; i< array_length(hist)-1; i++){

		
		if point_distance(ship_master.posx, ship_master.posy, hist[i].x,hist[i].y) < 600 {
			hist[i].tempX += random_range(-1,1) * (1-hist[i].noiseFactor)
			hist[i].tempX = clamp(hist[i].tempX,hist[i].x - 5,hist[i].x+5)
			hist[i].tempY += random_range(-1,1) * (1-hist[i].noiseFactor)
			hist[i].tempY = clamp(hist[i].tempY,hist[i].y - 5,hist[i].y+5)
	
			var _x = random_range(-maxDrift,maxDrift) * (1 - hist[i].noiseFactor)
			var _y = random_range(-maxDrift,maxDrift) * (1 - hist[i].noiseFactor)
			var pos = screenPos(hist[i].tempX+_x,hist[i].tempY+_y)
			draw_sprite(Blip,0,pos.x,pos.y)	

		}
	}
	surface_reset_target()
	}
}