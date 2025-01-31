
if oSonarMaster.scanning || oLidarMaster.scanning {
	draw_sprite_ext(sSonarHud,1+irandom(1),0,0,1,1,0,c_white,1)
} else
	draw_sprite_ext(sSonarHud,0,0,0,1,1,0,c_white,1)
for (var i = 0; i < array_length(drawables);i++){
	if drawables[i].isGui
		drawables[i].drawFunc()	
}


