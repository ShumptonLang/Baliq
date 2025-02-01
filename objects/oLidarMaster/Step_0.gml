//image_angle = 270-ship_master.angle
//sprite_set_offset(sprite_index, ship_master.posx, ship_master.posy)
camera_set_view_pos(view_camera[0], ship_master.posx-camera_get_view_width(view_camera[0])/2,ship_master.posy-camera_get_view_height(view_camera[0])/2)

camera_set_view_angle(view_camera[0],360-ship_master.angle)


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
	
if scanning {
var _scandeg = random(360)
var _scandif = sin(abs(degtorad(_scandeg-ship_master.angle+90)/2))

//Starting rotation is 0, 



//Resampling performs poorly. Find out how to make a distibution
while (random(1) < _scandif ){
	
	_scandeg = random(360)
	_scandif = sin(abs(degtorad(_scandeg-ship_master.angle+90)/2))
}
//print(_scandeg,ship_master.angle, abs((_scandeg-ship_master.angle)/2), sin(abs(degtorad(_scandeg-ship_master.angle)/2)))

var fidelity = random_range(1,90)
var _x = lengthdir_x(fidelity,_scandeg)
var _y = lengthdir_y(fidelity,_scandeg)




for(var i=0; i<7;i++){
	var floor_texture = [random(50),random(50)]
	//if(i > 2) array_insert(floor_hist,0,[px + floor_texture[0],py + floor_texture[1],i]);
		px -= _x
		py -= _y
		//draw_sprite(Blip,0,px,(py))
		//var __r = buffer_peek(map_buffer,_r,buffer_u8)
		var rayPoint = getPixelFromBuffer(buffer,px,py,4000,4000)

		//print(getPixelFromBuffer(buffer,px,py).a, getPixelFromBuffer(buffer,px,py).a == 255)
		//print(surface_getpixel(surf, px, py))
		//print(colour_get_red(surface_getpixel(surf, px, py)))
		//if (__a) print("Buffer Transfer Successful!  ", __a);
		
		//print("Trialing dummy point at: ",px, ", ", py)
		
		//White
		
		if(compareColor(rayPoint,white)){
			//print("Successful buffer query at: ",px, ", ", py)
			var tempX = px
			var tempY = py
			var r  = getPixelFromBuffer(buffer, tempX, tempY,4000,4000)
			
			tempX += _x / 2
			tempY += _y / 2
			for(var j=0; j < 5; j++){
				
				r = getPixelFromBuffer(buffer, tempX, tempY,4000,4000)
				if(compareColor(r,white)){
					tempX += _x
					tempY += _y
					
				} else {
					tempX -= _x
					tempY -= _y
				}
				
				_x /= 2
				_y /= 2
			}

			//instance_create_layer(px - ship_master.posx + 720,py - ship_master.posy + 540,"DisplayFrame",testpoint)
			//print("Success!")
			var wallPoint = {
				x : px,
				y : py,
				tempX : px,
				tempY : py,
				noiseFactor : 1
			}
			array_insert(hist,0,wallPoint)
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
		if false {
			array_insert(hist,0,[px,py,px,py,0.5])
			array_insert(floor_hist,0,[px ,py ,i])
		}
		
}
}

//print(array_length(hist))