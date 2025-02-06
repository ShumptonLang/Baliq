function screen2clip(x,y){
	var val = screen2uv(x,y)
	val = uv2clip(val.x,val.y)
	
	return val
}