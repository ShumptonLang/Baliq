





	
	
	//print(pullDirection)



//if global.mouse_occupied == "proxy" {
//	var new_angle = point_direction(x,y,global.mouseX,global.mouseY)
	
//	ShipMaster.shipStatus.sonarLidar.compassDeg += dcos(new_angle)
//	ShipMaster.shipStatus.sonarLidar.compassDeg %= 360
//}

rotv += (rotMaxV*pullDirection-rotv)*0.03
ControllerService.shipStatus.sonarLidar.rotationWheel += rotv

fmod_studio_system_set_parameter_by_name("rotationVelocity",rotv/rotMaxV)




