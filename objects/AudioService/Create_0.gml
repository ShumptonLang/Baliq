#region FMOD Banks and events
bank_ref = fmod_studio_system_load_bank_file(
	fmod_path_bundle("Desktop//Master.bank"),
	FMOD_STUDIO_LOAD_BANK.NORMAL);
strings_bank_ref = fmod_studio_system_load_bank_file(
	fmod_path_bundle("Desktop//Master.strings.bank"), FMOD_STUDIO_LOAD_BANK.NORMAL);
ambienceBankRef = fmod_studio_system_load_bank_file(
	fmod_path_bundle("Desktop//Ambience.bank"), FMOD_STUDIO_LOAD_BANK.NORMAL);
ambienceBankRef = fmod_studio_system_load_bank_file(
	fmod_path_bundle("Desktop//SFX.bank"), FMOD_STUDIO_LOAD_BANK.NORMAL);
	
	
eventB = fmod_studio_system_get_event("event:/basilicaAmbience");
eventBasilicaAmbience = fmod_studio_event_description_create_instance(eventB);
eventLidarEngaged = fmod_studio_system_get_event("event:/lidarTimer");
eventLidarEngagedI = fmod_studio_event_description_create_instance(
	eventLidarEngaged);
eventRotWheel = fmod_studio_system_get_event("event:/RotationWheelTurned");
eventRotWheelInst = fmod_studio_event_description_create_instance(eventRotWheel);
eventGroan = fmod_studio_system_get_event("event:/hullGroans");
eventGroanInst = fmod_studio_event_description_create_instance(eventGroan);
eventShipAmbience = fmod_studio_system_get_event("event:/shipAmbience");
ShipAmbienceInst = fmod_studio_event_description_create_instance(eventShipAmbience);

commsStartup = fmod_studio_system_get_event("event:/commsStartup");
commsStartupI = fmod_studio_event_description_create_instance(commsStartup);

activeServices = array_create(0)
#endregion



/**
 * Creates an Audio Service manager for the given event. Customizeable updates and kill toggles can also be supplied
 * @param {event_instance_ref} audioEvent The FMOD Event Instance to manage
 * @param {any*} updateFunc A function that is called every update tick. Updates are passed the Event Instance
 * @param {Function} stateFunc A function that handles termination of an Audio Service. The Audio Service will be terminated when this function returns true.
 */
function play(audioEvent,updateFunc, stateFunc = function(){return false}){
		
		array_insert(activeServices,0,{event:audioEvent,update:updateFunc,state:stateFunc})
		//fmod_studio_event_instance_start(audioEvent)
}

function playStep(service){
	
		service.update(service.event)
		return service.state(service.event)
}


#region Object Services

#region Wheel Audio Service
function updateWheelSound(event) {
	if fmod_studio_event_instance_get_playback_state(event) == FMOD_STUDIO_PLAYBACK_STATE.STOPPED
		fmod_studio_event_instance_start(event)

	var rot = ControllerService.shipStatus.sonarLidar.rotationWheel.delta
	//if abs(rot/10) > 0.3 and fmod_studio_event_instance_get_playback_state(AudioService.eventGroanInst) == FMOD_STUDIO_PLAYBACK_STATE.STOPPED
	//	fmod_studio_event_instance_start(AudioService.eventGroanInst)

	fmod_studio_system_set_parameter_by_name("rotationVelocity",rot)
	
	
			
}


AudioService.play(AudioService.eventRotWheelInst,updateWheelSound)

#endregion

#region MovementVelocity
function updateMovementSound(event) {
	if fmod_studio_event_instance_get_playback_state(event) == FMOD_STUDIO_PLAYBACK_STATE.STOPPED
		fmod_studio_event_instance_start(event)

	var vel = ControllerService.shipStatus.ship.velocity
	//if abs(rot/10) > 0.3 and fmod_studio_event_instance_get_playback_state(AudioService.eventGroanInst) == FMOD_STUDIO_PLAYBACK_STATE.STOPPED
	//	fmod_studio_event_instance_start(AudioService.eventGroanInst)

	fmod_studio_system_set_parameter_by_name("shipVelocity",vel)
	//print(AudioService.eventRotWheelInst,fmod_studio_event_instance_get_parameter_by_name(AudioService.eventRotWheelInst, "rotationVelocity"),ControllerService.shipStatus.sonarLidar.rotationWheel.delta)
	
			
}


AudioService.play(AudioService.eventGroanInst,updateMovementSound)

#endregion

#region Ship Ambience
function shipAmbienceController(event) {
	//if fmod_studio_event_instance_get_playback_state(event) == FMOD_STUDIO_PLAYBACK_STATE.STOPPED
	//	fmod_studio_event_instance_start(event)
	var timePos = fmod_studio_event_instance_get_timeline_position(event)/1000
	if timePos > 35
		ControllerService.shipStatus.ship.ambienceLaugh = 0

	var ambienceLaugh = ControllerService.shipStatus.ship.ambienceLaugh
	

	
	fmod_studio_event_instance_set_parameter_by_name(event,"dappLaugh",ambienceLaugh)
	
	
	
			
}

//AudioService.play(AudioService.ShipAmbienceInst,shipAmbienceController)
#endregion

#region Comms Startup
function commsStartupController(event) {

	

	
	fmod_studio_event_instance_set_parameter_by_name(event,"stage",ControllerService.shipStatus.comms.introState)
	
	
	
			
}

AudioService.play(AudioService.commsStartupI,commsStartupController)
#endregion

#endregion

