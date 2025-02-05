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
lastHistTotal = 0

isGui = true
drawFunc = function(){
	if surface_exists(oSLMaster.lidarSurf){
	surface_set_target(oSLMaster.lidarSurf)
	
	if lastHistTotal != array_length(hist){
		draw_clear_alpha($010101,0)
		lastHistTotal = array_length(hist)
	for (var i=0; i< array_length(hist)-1; i++){

		
		//if point_distance(ship_master.posx, ship_master.posy, hist[i].x,hist[i].y) < 600 
		{
			hist[i].tempX += random_range(-1,1) * (1-hist[i].noiseFactor)
			hist[i].tempX = clamp(hist[i].tempX,hist[i].x - 5,hist[i].x+5)
			hist[i].tempY += random_range(-1,1) * (1-hist[i].noiseFactor)
			hist[i].tempY = clamp(hist[i].tempY,hist[i].y - 5,hist[i].y+5)
	
			var _x = random_range(-maxDrift,maxDrift) * (1 - hist[i].noiseFactor)
			var _y = random_range(-maxDrift,maxDrift) * (1 - hist[i].noiseFactor)
			var pos = screenPos(hist[i].tempX+_x,hist[i].tempY+_y)
			//draw_sprite(Blip,0,pos.x,pos.y)	

		}
	}
	draw_sprite_part_ext(spr_start,1,ShipMaster.posx-oSLMaster.view_width/2,ShipMaster.posy-oSLMaster.view_height/2,oSLMaster.view_width,oSLMaster.view_height,0,0,1,1,c_red,0.5)
	draw_sprite_part_ext(dummyNoise,0,0,0,oSLMaster.view_width,oSLMaster.view_height,0,0,10,10,c_red,0.8)
	
	}
	surface_reset_target()
	}
}