for (var i = 0; i < array_length(activeServices); i++){
	var service = array_shift(activeServices)
	
	if !playStep(service)
		array_push(activeServices,service)
}

//print(fmod_studio_event_instance_get_playback_state(eventRotWheelInst),
//fmod_studio_event_instance_get_parameter_by_name(eventRotWheelInst, "rotationVelocity"),ControllerService.shipStatus.sonarLidar.rotationWheel.delta)