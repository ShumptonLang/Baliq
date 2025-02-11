
var mOccupiedChanged = mOccupiedOld != global.mouse_occupied
mOccupiedOld = global.mouse_occupied



var pullDirection = 0

if (global.mouse_occupied == self){

	
	var _x = device_mouse_x_to_gui(0)
	var _y = device_mouse_y_to_gui(0)
	
	var new_angle = point_direction(x,y,_x,_y)
	pullDirection = dcos(new_angle)
	
	
	//print(pullDirection)

} else {
	
}



fmod_studio_system_set_parameter_by_name("rotationVelocity",rotv/rotMaxV)


rotv += (rotMaxV*pullDirection-rotv)*0.03
rot += rotv

master.updateStatus("rotationWheel",rotv/25)



