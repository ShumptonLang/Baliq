function screen2uv(x,y){
	
	x = x/camera_get_view_width(0)
	y = y/camera_get_view_height(0)
	
	return {x:x, y:y}

}