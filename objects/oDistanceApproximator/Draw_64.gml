draw_line_width(x,y,hand1.x,hand1.y,2)
draw_sprite_ext(sDapproxBall,0,hand1.x,hand1.y,0.3,0.3,0,c_white,1)

draw_line_width(x,y,hand2.x,hand2.y,2)
draw_sprite_ext(sDapproxBall,0,hand2.x,hand2.y,0.3,0.3,0,c_white,1)


if true{
	global.distSurfs[2] = !global.distSurfs[2]
	var distSurfIter = global.distSurfs[2]

	surface_set_target(global.distSurfs[distSurfIter])
	draw_clear(c_black)
	draw_surface(global.distSurfs[!distSurfIter],0,1)
	
	var point = ((1-hand1.dist/maxDist)/2)*surface_get_width(global.distSurfs[0])-3
	if hand1.frame >= 2 and hand1.dist != 0 and !hand1.fail
		draw_line(point,0,lastPts[0],1)
	lastPts[0] = point

	point = (hand2.dist/maxDist/2)*surface_get_width(global.distSurfs[0])+surface_get_width(global.distSurfs[0])/2
	if hand2.frame >= 2 and hand2.dist != 0 and !hand2.fail
		draw_line(point,0,lastPts[1],1)
	lastPts[1] = point

	draw_point_color(surface_get_width(global.distSurfs[0])/2,0,c_dkgray)
	

	surface_reset_target()
	

}


draw_surface(global.distSurfs[global.distSurfs[2]],1000,50)

