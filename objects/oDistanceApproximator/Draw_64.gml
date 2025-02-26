draw_line_width(x,y,hand1.x,hand1.y,2)
draw_sprite_ext(sDapproxBall,0,hand1.x,hand1.y,0.3,0.3,0,c_white,1)

draw_line_width(x,y,hand2.x,hand2.y,2)
draw_sprite_ext(sDapproxBall,0,hand2.x,hand2.y,0.3,0.3,0,c_white,1)


if updateDist{
	global.distSurfs[2] = !global.distSurfs[2]
	var distSurfIter = global.distSurfs[2]

	surface_set_target(global.distSurfs[distSurfIter])
	draw_clear(c_black)
	draw_surface(global.distSurfs[!distSurfIter],0,1)

	var point = ((1-hand1.dist/maxDist)/2)*surface_get_width(global.distSurfs[0])
	draw_point(point,0)

	point = (hand2.dist/maxDist/2)*surface_get_width(global.distSurfs[0])+surface_get_width(global.distSurfs[0])/2
	draw_point(point,0)

	draw_point_color(surface_get_width(global.distSurfs[0])/2,0,c_dkgray)

	surface_reset_target()
	
	updateDist = false
}

draw_surface(global.distSurfs[global.distSurfs[2]],1000,50)