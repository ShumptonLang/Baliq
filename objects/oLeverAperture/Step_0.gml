

var changed = engaged

//Engage the scan when it reaches the end of the rail
if (x >= initPos[0] + range){ 
	engaged = true
	
	
}
//Turn off the sca and stop spring force when the lever is pulled to the beginning

changed = engaged != changed

if engaged && changed {
	global.mouse_occupied = 0
	reject_mouse = true
}
	
oLidarMaster.scanning = engaged
	
	
	
	
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
if (global.mouse_occupied != self and !engaged){
	x -= x/(initPos[0] + range)*range*0.1
}


x = clamp(x,initPos[0],initPos[0] + range)





	
	
