draw_sprite_ext(sprite_index,0,x,y,0.5,0.5,0,c_white,1)

if ControllerService.shipStatus.map.isScanning
	draw_sprite_ext(sDigestLED,ControllerService.shipStatus.map.isErrored?irandom(1):1,232,88,0.5,0.5,0,c_white,1)
else
	draw_sprite_ext(sDigestLED,0,232,88,0.5,0.5,0,c_white,1)