
var mOccupiedChanged = mOccupiedOld != global.mouse_occupied
mOccupiedOld = global.mouse_occupied



var pullDirection = 0

if (global.mouse_occupied == self){
	var _x = device_mouse_x_to_gui(0)
	var _y = device_mouse_y_to_gui(0)
	
	var new_angle = point_direction(x,y,_x,_y)
	pullDirection = dcos(new_angle)
	
	
	//print(pullDirection)

}
if(mOccupiedChanged and global.mouse_occupied != self){

	}
	

rotv += (rotMaxV*pullDirection-rotv)*0.01
rot += rotv

if ship_master.forward_normal{
ship_master.angle -= rotv/25
} else {
ship_master.angle -= rotv/40
}

