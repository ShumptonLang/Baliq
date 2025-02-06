//image_angle = 270-ship_master.angle
//sprite_set_offset(sprite_index, ship_master.posx, ship_master.posy)

var px = ship_master.posx
var py = ship_master.posy

var _fx = lengthdir_x(29,ship_master.angle+90)
var _fy = lengthdir_y(29,ship_master.angle+90)

if false {
var test_x = 744;
var test_y = 379;
var width = 4000;
var pixel = getPixelFromBuffer(buffer,test_x,test_y)

// Read directly from buffer
show_debug_message("Buffer values at " + string(test_x) + "," + string(test_y) + ":");
show_debug_message("B: " + string(pixel.b));
show_debug_message("G: " + string(pixel.g));
show_debug_message("R: " + string(pixel.r));
show_debug_message("A: " + string(pixel.a));

// Compare with surface
var surf_pixel = surface_getpixel_ext(surf, test_x, test_y);
show_debug_message("Surface values at same position:");
show_debug_message("R: " + string(color_get_red(surf_pixel)));
show_debug_message("G: " + string(color_get_green(surf_pixel)));
show_debug_message("B: " + string(color_get_blue(surf_pixel)));
show_debug_message("A: " + string(surf_pixel >> 24));
}

//print(getPixelFromBuffer(buffer, px+_fx, py+_fy))
if (getPixelFromBuffer(buffer, px+_fx, py+_fy).r == 255){
	ship_master.contact = true
	//print("bang!")
}
	
if scanning and !waitingForScan{
	for (var v = 0; v < 1;v++){
	while(scanIter < scanTotal){
		var _scandeg = (scanIter/scanTotal) * 360

//Starting rotation is 0, 



//Resampling performs poorly. Find out how to make a distibution

//print(_scandeg,ship_master.angle, abs((_scandeg-ship_master.angle)/2), sin(abs(degtorad(_scandeg-ship_master.angle)/2)))
		//print(_scandeg)
		var fidelity = random_range(-9,10)
		var _x = lengthdir_x(10+fidelity/10,_scandeg+fidelity)
		var _y = lengthdir_y(10+fidelity/10,_scandeg+fidelity)


		px = ShipMaster.posx
		py = ShipMaster.posy
		for(var i=0; i<100;i++){
				px -= _x
				py -= _y
				
				
	
				var rayPoint = getPixelFromBuffer(buffer,px,py)

				//print(getPixelFromBuffer(buffer,px,py).a, getPixelFromBuffer(buffer,px,py).a == 255)
				//print(surface_getpixel(surf, px, py))
				//print(colour_get_red(surface_getpixel(surf, px, py)))
				//if (__a) print("Buffer Transfer Successful!  ", __a);
		
				//print("Trialing dummy point at: ",px, ", ", py)
		
				//White
		
				if(rayPoint.r){
					//print("Successful buffer query at: ",px, ", ", py)
					var tempX = px
					var tempY = py

					
					px = tempX
					py = tempY

					var wallPoint = {
						x : px,
						y : py,
						noiseX : random(255),
						noiseY : random(255),
						material: rayPoint
					}
					
					var storePoint = string(
					int64(wallPoint.x - (wallPoint.x%chunkSize))) 
					+ "." + 
					string(
					int64(wallPoint.y - (wallPoint.y%chunkSize)))
					
					var hash = variable_get_hash(storePoint)
					
					if !variable_struct_exists(pointMap,storePoint){
						
						struct_set_from_hash(pointMap,hash,array_create(0))

					}
					
					var cell = struct_get_from_hash(pointMap,hash)
					
					if  (array_length(cell) > 20){
						array_pop(cell)
						
					} 
					array_insert(cell,0,wallPoint)
					
					
					
					break;
				}

		
		}
		scanIter ++
	}
	scanIter = 0
	}
	waitingForScan = 1
	
	
}
if waitingForScan{
	wait += delta_time / 1000000
	if wait >= waitLength {
		wait = 0
		scanning = false
		waitingForScan = false
	}
}



//Update pointsToRender Points


var mapPointX = round(ShipMaster.posx / chunkSize)*chunkSize
var mapPointY = round(ShipMaster.posy / chunkSize)*chunkSize


var lookupRange = 4
for (var i = 0; i < 2*lookupRange+1; i++) {
		for (var j = 0; j < 2*lookupRange+1; j++){
				
				var cellPos = string((i-lookupRange)*chunkSize + mapPointX) + "." + string((j-lookupRange)*chunkSize + mapPointY)
				var cellPosHash = variable_get_hash(cellPos)
				var cellArray = struct_get_from_hash(pointMap,cellPosHash)
				
				if array_length(cellArray) > 0{
					pointsToRender = array_concat(pointsToRender,cellArray)	
					
				}
				
				
		}
}
print(array_length(pointsToRender))

//Apply modifications to pointsToRender
for( var k = 0; k < array_length(pointsToRender); k++){
					

					var screenSrc = screenPos(pointsToRender[k].x, pointsToRender[k].y);

				
					var normPos = normalizeToCenter(screenSrc)
					var angle = point_direction(720,540,normPos.x,normPos.y) +ShipMaster.angle
					
					pointsToRender[k].degree = angle

					//print(normPos)
					normPos = screen2clip(normPos.x,normPos.y)
					pointsToRender[k].norm = normPos
					//print(normPos)
					
					var siltImpact = pointsToRender[k].material.g / 255
					
					var warpMin = 1 - siltImpact/10
					var warpMax = 1 + siltImpact/10
					
					
					var warpMult = (warpMax-warpMin)
					
					normPos.x *= warpMult * (dsin(5*angle+current_time/10)/2) + warpMin
					normPos.y *= warpMult * (dsin(5*angle+current_time/20)/2) + warpMin
					
					warpMin = 1 - siltImpact/20
					warpMax = 1 + siltImpact/15

					warpMult = (warpMax-warpMin)
					
					normPos.x *= warpMult * (dsin(20*angle-current_time/30)/2) + warpMin
					normPos.y *= warpMult * (dsin(20*angle-current_time/10)/2) + warpMin
					
					var warpColor = ((1-abs(dcos(5*angle+current_time/100)))*10)
					warpColor = max(warpColor,0)

					
					//normPos.x *= random_range(0.9,1.1)
					//normPos.y *= random_range(0.9,1.1)
					//print(normPos)
					normPos = clip2screen(normPos.x,normPos.y)
					//print(normPos)
					//var distTo = 255/(point_distance(cellArray[k].tempX, cellArray[k].tempY,cellArray[k+1].tempX,cellArray[k+1].tempY))*10
					//var distFrom = 255/(point_distance(cellArray[k].tempX, cellArray[k].tempY,cellArray[k-1].tempX,cellArray[k-1].tempY))*10
					//var dist = min(min(distTo,distFrom),0)
					var distShip = 255/power(point_distance(pointsToRender[k].x, pointsToRender[k].y,ShipMaster.posx,ShipMaster.posy),3)*50000
					var dist = distShip+(warpColor*siltImpact) + (1-siltImpact)*2
					
					pointsToRender[k].displayX = normPos.x
					pointsToRender[k].displayY = normPos.y
					pointsToRender[k].lumin = dist
					
					
					
}
array_sort(pointsToRender,function(elm1, elm2){
						return elm1.degree - elm2.degree;	
					});

//print(array_length(hist))