function drawDrawable(obj, drawFunc){



	for (var i=0; i< array_length(obj.floor_hist); i++){
	//draw_set_alpha(0.04 / floor_hist[i][2])
		var current_point = array_pop(obj.floor_hist)
		if current_point.isSurfaceLevel {
			
		} else {
			
		}
		
	}
	

	for (var i=0; i< array_length(obj.hist)-1; i++){

		
		if point_distance(ship_master.posx, ship_master.posy, hist[i].x,hist[i].y) < 600 {
			hist[i].tempX += random_range(-1,1) * (1-hist[i].noiseFactor)
			hist[i].tempX = clamp(hist[i].tempX,hist[i].x - 5,hist[i].x+5)
			hist[i].tempY += random_range(-1,1) * (1-hist[i].noiseFactor)
			hist[i].tempY = clamp(hist[i].tempY,hist[i].y - 5,hist[i].y+5)
	
			var _x = random_range(-maxDrift,maxDrift) * (1 - hist[i].noiseFactor)
			var _y = random_range(-maxDrift,maxDrift) * (1 - hist[i].noiseFactor)

			draw_sprite(Blip,0,hist[i].tempX+_x,hist[i].tempY+_y)	

		}
	}
	
	gpu_set_blendmode(bm_normal)

	draw_set_alpha(1)
	//draw_sprite(spr_start,2,0,0)
	surface_reset_target()
	//draw_surface(shadowSurf,0,0)


	if(keyboard_check(vk_shift)){
		var tempSurf = surface_create(4000,4000)
		buffer_set_surface(buffer,tempSurf,0)
		draw_surface(tempSurf,0,0)
	}
}