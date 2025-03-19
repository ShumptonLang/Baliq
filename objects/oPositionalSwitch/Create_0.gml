// Inherit the parent event
event_inherited();

_start = {x:0,y:0}
_end = {x:100,y:100}



pctPulled = 0

function getPositionPulled(){
	var _x = oInputManager.mouse_x_gui
	var _y = oInputManager.mouse_y_gui
	
	var mouseScalar = point_distance(_start.x,_start.y,_x,_y)
	var mouseAngle = point_direction(_start.x,_start.y,_x,_y)
	
	var railScalar = point_distance(_start.x,_start.y,_end.x,_end.y)
	var railAngle = point_direction(_start.x,_start.y,_end.x,_end.y)
	
	var theta = angle_difference(mouseAngle,railAngle)
	
	var dot = dcos(theta)*mouseScalar
	
	dot = clamp(dot,0,railScalar)
	
	pctPulled = dot/railScalar

	//print(dot,pctPulled)
	return dot
}