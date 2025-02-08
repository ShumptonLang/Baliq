
var mOccupiedChanged = mOccupiedOld != global.mouse_occupied
mOccupiedOld = global.mouse_occupied



var pullDirection = 0

if (global.mouse_occupied == self){

	if fmod_studio_event_instance_get_playback_state(eventRotWheelInst) == FMOD_STUDIO_PLAYBACK_STATE.STOPPED{
		fmod_studio_event_instance_start(eventRotWheelInst);

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
	if fmod_studio_event_instance_get_playback_state(eventGroanInst) == FMOD_STUDIO_PLAYBACK_STATE.STOPPED and ShipMaster.shipPower
		fmod_studio_event_instance_start(eventGroanInst);
}

fmod_studio_system_set_parameter_by_name("rotationVelocity",rotv/rotMaxV)


rotv += (rotMaxV*pullDirection-rotv)*0.03
rot += rotv

if ShipMaster.shipStatus.digestive.running
	ship_master.angle -= rotv/25



