function clipscreen2screen(x,y){
	x += camera_get_view_width(0)/2
	y += camera_get_view_height(0)/2
	return {x:x,y:y}
}