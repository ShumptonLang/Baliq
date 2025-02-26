




var pullDirection = 0

if (global.mouse_occupied == self){

	
	var _x = device_mouse_x_to_gui(0)
	var _y = device_mouse_y_to_gui(0)
	
	var new_angle = point_direction(x,y,_x,_y)
	pullDirection = dcos(new_angle)
	
	
	//print(pullDirection)

} 

if global.mouse_occupied == "proxy" {
	var new_angle = point_direction(x,y,global.mouseX,global.mouseY)
	
	proxyAngle += dcos(new_angle)
	proxyAngle %= 360
}

print(proxyAngle)

fmod_studio_system_set_parameter_by_name("rotationVelocity",rotv/rotMaxV)


rotv += (rotMaxV*pullDirection-rotv)*0.03
rot += rotv

master.updateStatus("rotationWheel",rotv/25)



