if state == "errored" or state == "failure" 
	draw_sprite_ext(sDigestLED,1,1275,100,1,1,0,c_red,1)
else if state == "idle"
	draw_sprite_ext(sDigestLED,1,1275,100,1,1,0,c_white,1)
else
	draw_sprite_ext(sDigestLED,0,1275,100,1,1,0,c_white,1)
