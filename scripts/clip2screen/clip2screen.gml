function clip2screen(x,y){
	var val = clip2clipscreen(x,y)

	val = clipscreen2screen(val.x,val.y)

	
	return val
}