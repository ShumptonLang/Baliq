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
if (getPixelFromBuffer(buffer, px+_fx, py+_fy,4000,4000).a == 255){
	ship_master.contact = true
	//print("bang!")
}
	
if scanning and !waitingForScan{
	for (var v = 0; v < 15;v++){
	while(scanIter < scanTotal){
		var _scandeg = (scanIter/scanTotal) * 360 + irandom_range(-5,5)

//Starting rotation is 0, 



//Resampling performs poorly. Find out how to make a distibution

//print(_scandeg,ship_master.angle, abs((_scandeg-ship_master.angle)/2), sin(abs(degtorad(_scandeg-ship_master.angle)/2)))
		//print(_scandeg)
		var fidelity = random_range(-10,10)
		var _x = lengthdir_x(10+fidelity/10,_scandeg+fidelity)
		var _y = lengthdir_y(10+fidelity/10,_scandeg+fidelity)


		px = ShipMaster.posx
		py = ShipMaster.posy
		for(var i=0; i<50;i++){
				px -= _x
				py -= _y
				
				
	
				var rayPoint = getPixelFromBuffer(buffer,px,py,4000,4000)

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
						tempX : px,
						tempY : py,
						noiseX : random(255),
						noiseY : random(255)
					}
					
					var storePoint = string(
					int64(wallPoint.x - (wallPoint.x%100))) 
					+ "." + 
					string(
					int64(wallPoint.y - (wallPoint.y%100)))
					
					if !ds_map_exists(hHist,storePoint){
							ds_map_add(hHist,storePoint,array_create(0))
					}
					if  (array_length(ds_map_find_value(hHist, storePoint)) > 20){
						array_pop(ds_map_find_value(hHist, storePoint))
						
					} 
					array_insert(ds_map_find_value(hHist, storePoint),0,wallPoint)
					
					var floorPoint = {
						x : px,
						y : py,
						wallX : tempX,
						wallY : tempY,
						angle : _scandeg,
						isSurfaceLevel : false
					}
			
					array_insert(floor_hist,0,floorPoint)
					break;
				}
		//Need to fix

		
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

//print(array_length(hist))