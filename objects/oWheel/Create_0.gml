// Inherit the parent event
event_inherited();
interaction_shape = "custom"



prvMouseDeg = -1
prvHandleDeg = 180
pullDirection = 0
function on_interaction_update() {
	var wIdx = variable_struct_get(ControllerService.shipStatus.sonarLidar.rotationWheel, idx)
	
    pullDirection = 0
	var _x = oInputManager.mouse_x_gui
	var _y = oInputManager.mouse_y_gui
	
	var new_angle = point_direction(x,y,_x,_y)
	pullDirection = dcos(new_angle) * point_distance(x,y,oInputManager.mouse_x_gui,oInputManager.mouse_y_gui)/200

	var oldRot = wIdx
	var newRot = wIdx + pullDirection*0.01
	if oldRot < 0.99 and newRot >= 0.99
		audio_play_sound(click,1,0)


	variable_struct_set(ControllerService.shipStatus.sonarLidar.rotationWheel, idx, newRot)
	variable_struct_set(ControllerService.shipStatus.sonarLidar.rotationWheel, idx, clamp(variable_struct_get(ControllerService.shipStatus.sonarLidar.rotationWheel, idx),0,1))
	//ControllerService.shipStatus.sonarLidar.rotationWheel = clamp(ControllerService.shipStatus.sonarLidar.rotationWheel,0,1)
	
	

	
}

function on_interaction_end(){
	pullDirection = 0	
}

function interaction_contains_point(x, y) {
	var wIdx = variable_struct_get(ControllerService.shipStatus.sonarLidar.rotationWheel, idx)
	if point_distance(self.x,self.y,x,y) < 100 
	and ControllerService.shipStatus.map.stateMachine.currentState.name == "waitIgnition"
	and wIdx < 0.99
	
		return true
}

