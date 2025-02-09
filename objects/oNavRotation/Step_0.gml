
var mOccupiedChanged = mOccupiedOld != global.mouse_occupied
mOccupiedOld = global.mouse_occupied



var pullDirection = 0

if (global.mouse_occupied == self){

	if fmod_studio_event_instance_get_playback_state(ShipMaster.eventRotWheelInst) == FMOD_STUDIO_PLAYBACK_STATE.STOPPED{
		fmod_studio_event_instance_start(ShipMaster.eventRotWheelInst);

	}
	
	var _x = device_mouse_x_to_gui(0)
	var _y = device_mouse_y_to_gui(0)
	
	var new_angle = point_direction(x,y,_x,_y)
	pullDirection = dcos(new_angle)
	
	
	//print(pullDirection)

} else {
	
}
if(mOccupiedChanged and global.mouse_occupied == self){
		waitForCue = true
		
	}
if waitForCue and abs(rotv/rotMaxV) > 0.3 {
	waitForCue = false
	if fmod_studio_event_instance_get_playback_state(ShipMaster.eventGroanInst) == FMOD_STUDIO_PLAYBACK_STATE.STOPPED
		fmod_studio_event_instance_start(ShipMaster.eventGroanInst);
}

fmod_studio_system_set_parameter_by_name("rotationVelocity",rotv/rotMaxV)


rotv += (rotMaxV*pullDirection-rotv)*0.03
rot += rotv

master.updateStatus("rotationWheel",rotv/25)



