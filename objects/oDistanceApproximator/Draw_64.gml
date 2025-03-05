//draw_line_width(x,y,hand1.x,hand1.y,2)
//draw_sprite_ext(sDapproxBall,0,hand1.x,hand1.y,0.3,0.3,0,c_white,1)

//draw_line_width(x,y,hand2.x,hand2.y,2)
//draw_sprite_ext(sDapproxBall,0,hand2.x,hand2.y,0.3,0.3,0,c_white,1)

var minDL = 100000
var maxDL = -1000000

var minDR = 100000
var maxDR = -1000000


for (var i = 0; i < pinsPCol; i++){
	
	var currPoint = hand1.dist[i]
	if currPoint != maxDist{
		minDL = min(currPoint,minDL)	
		maxDL = max(currPoint,maxDL)
	}
	
	currPoint = hand2.dist[i]
	if currPoint != maxDist{
		minDR = min(currPoint,minDR)	
		maxDR = max(currPoint,maxDR)
	}
		
}

//Scale factor to normalize between 0 and maxDist

var rXScale = maxDist/(maxDR-minDR)
var lXScale = maxDist/(maxDL-minDL)

surface_set_target(global.distSurfs[0])
draw_clear(c_black)
for (var i = 0; i < pinsPCol; i++){


		//draw_line(1000-validRowL[i-1],(i-1)*1+100, 1000-validRowL[i],i*1+100)
	draw_line((hand1.dist[pinsPCol-1-i]-minDL)*lXScale/maxDist*surface_get_width(global.distSurfs[0]),i,surface_get_width(global.distSurfs[0]),i)
	
	

		
	//draw_sprite_ext(Sprite33,0,validRows[i][1] + 1000,i*4+100,-0.5,0.3,0,c_white,0.5 )
}

surface_reset_target()

surface_set_target(global.distSurfs[1])
draw_clear(c_black)
for (var i = 0; i < pinsPCol; i++){

	

	draw_line((hand2.dist[i]-minDR)*rXScale/maxDist*surface_get_width(global.distSurfs[1]),i,surface_get_width(global.distSurfs[1]),i)
		
	
		
	//draw_sprite_ext(Sprite33,0,validRows[i][1] + 1000,i*4+100,-0.5,0.3,0,c_white,0.5 )
}
surface_reset_target()

draw_surface_part_ext(global.distSurfs[0],0,0,surface_get_width(global.distSurfs[0]),pinsPCol,1040,100,-0.5,surface_get_height(global.distSurfs[0])/pinsPCol,c_white,1)
draw_surface_part_ext(global.distSurfs[1],0,0,surface_get_width(global.distSurfs[1]),pinsPCol,1056,100,0.5,surface_get_height(global.distSurfs[1])/pinsPCol,c_white,1)





