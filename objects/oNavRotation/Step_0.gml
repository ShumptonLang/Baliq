
var mOccupiedChanged = mOccupiedOld != global.mouse_occupied
mOccupiedOld = global.mouse_occupied



var pullDirection = 0

if (global.mouse_occupied == self){
	if audio_is_paused(metalclick)
		audio_resume_sound(metalclick)

	
	var _x = device_mouse_x_to_gui(0)
	var _y = device_mouse_y_to_gui(0)
	
	var new_angle = point_direction(x,y,_x,_y)
	pullDirection = dcos(new_angle)
	
	
	//print(pullDirection)

} else {
	if audio_sound_get_pitch(metalclick) < 0.9 {
		audio_pause_sound(metalclick)	
	}
}
if(mOccupiedChanged and global.mouse_occupied == self){
		waitForCue = true
		
	}
if waitForCue and rotv/rotMaxV > 0.1 {
	waitForCue = false
	audio_play_sound(Groan2,1,0,random_range(0.1,0.3),0,random_range(0.4,0.7))
}


audio_sound_pitch(metalclick,1.8*abs(rotv)/rotMaxV)	



rotv += (rotMaxV*pullDirection-rotv)*0.05
rot += rotv

if false{
ship_master.angle -= rotv/25
} else {
ship_master.angle -= rotv/40
}

