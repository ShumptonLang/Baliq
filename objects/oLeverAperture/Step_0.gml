

var changed = engaged

//Engage the scan when it reaches the end of the rail
if (x >= initPos[0] + range){ 
	engaged = true
	
}
//Turn off the sca and stop spring force when the lever is pulled to the beginning
if (x - initPos[0] < 5) && engaged{
	engaged = false
	falling = false
	global.mouse_occupied = 0
}
changed = engaged != changed

if engaged && changed {
	global.mouse_occupied = 0
	reject_mouse = true
}
	
oLidarMaster.scanning = engaged
	
	
	if changed && engaged{ 
		if audio_is_playing(sonarlaser) {
			audio_stop_sound(sonarlaser)
			audio_sound_gain(sonarlaser,1,0)
			
		}
		audio_play_sound(sonarlaser,1,1,1,0,2.1)
	}
	if changed && !engaged audio_sound_gain(sonarlaser,0, 100)
	
//print(engaged,global.mouse_occupied,reject_mouse)


if(global.mouse_occupied == self && !engaged){
	var _x = device_mouse_x_to_gui(0)
	var _y = device_mouse_y_to_gui(0)
	
	var new_angle = point_direction(x,y,_x,_y)
	
	var pull_dir = sqr(dcos(new_angle))
	var delta_pulled = (_x-x)*abs(pull_dir)
	//delta_pulled = _x
	x += delta_pulled


	
}
if falling {
	var acceleration = (-_k * (x-initPos[0]) + -0.5 * velocity);
	velocity += acceleration
	x += velocity
}

x = clamp(x,initPos[0],initPos[0] + range)





	
	
