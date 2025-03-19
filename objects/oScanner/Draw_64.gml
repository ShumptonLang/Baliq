draw_self()

if ControllerService.shipStatus.map.isScanning
	draw_sprite_ext(sDigestLED,ControllerService.shipStatus.map.isErrored?irandom(1):1,112,70,1,1,0,c_white,1)
else
	draw_sprite_ext(sDigestLED,0,112,70,1,1,0,c_white,1)