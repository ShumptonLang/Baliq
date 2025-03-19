// Inherit the parent event
event_inherited();
interaction_shape = "custom"

_start = [560,906]
x = _start[0]
y = _start[1]

prvMouseDeg = -1
prvHandleDeg = 180
rot = 0

function on_interaction_update() {
    var pullDirection = 0



	
	var _x = oInputManager.mouse_x_gui
	var _y = oInputManager.mouse_y_gui
	
	var new_angle = point_direction(x,y,_x,_y)
	pullDirection = dcos(new_angle)
	rot += pullDirection


	ShipMaster.offsetMovement(,pullDirection/25)
	
}

function interaction_contains_point(x, y) {
	if point_distance(self.x,self.y,x,y) < 100 and ShipMaster.shipStatus.ship.navigationState == "followingPath"
		return true
}

