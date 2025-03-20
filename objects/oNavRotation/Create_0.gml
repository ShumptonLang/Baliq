// Inherit the parent event
event_inherited();
interaction_shape = "custom"

_start = [560,906]
x = _start[0]
y = _start[1]

prvMouseDeg = -1
prvHandleDeg = 180
pullDirection = 0
function on_interaction_update() {
    pullDirection = 0
	var _x = oInputManager.mouse_x_gui
	var _y = oInputManager.mouse_y_gui
	
	var new_angle = point_direction(x,y,_x,_y)
	pullDirection = dcos(new_angle)

	var oldRot = ControllerService.shipStatus.sonarLidar.rotationWheel
	var newRot = ControllerService.shipStatus.sonarLidar.rotationWheel + pullDirection*0.01
	if oldRot < 0.99 and newRot >= 0.99
		audio_play_sound(click,1,0)

	ControllerService.shipStatus.sonarLidar.rotationWheel = newRot
	ControllerService.shipStatus.sonarLidar.rotationWheel = clamp(ControllerService.shipStatus.sonarLidar.rotationWheel,0,1)
	
	print(ControllerService.shipStatus.sonarLidar.rotationWheel)
	
}

function on_interaction_end(){
	pullDirection = 0	
}

function interaction_contains_point(x, y) {
	if point_distance(self.x,self.y,x,y) < 100 
	and ControllerService.shipStatus.map.stateMachine.currentState.name == "waitIgnition"
	and ControllerService.shipStatus.sonarLidar.rotationWheel < 0.99
	
		return true
}

