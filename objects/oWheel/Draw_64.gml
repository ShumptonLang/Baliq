if idx == "one"
	draw_sprite_ext(sWheel,0, x,y,1.5,1.5,variable_struct_get(ControllerService.shipStatus.sonarLidar.rotationWheel,idx)*360,c_white,
	ControllerService.shipStatus.map.stateMachine.currentState.name == "waitIgnition")
else
	draw_sprite_ext(sWheel,0, x,y,-1.5,1.5,variable_struct_get(ControllerService.shipStatus.sonarLidar.rotationWheel,idx)*360,c_white,
	ControllerService.shipStatus.map.stateMachine.currentState.name == "waitIgnition")

