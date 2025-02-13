#region FMOD Banks and events
bank_ref = fmod_studio_system_load_bank_file(fmod_path_bundle("Desktop//Master.bank"), FMOD_STUDIO_LOAD_BANK.NORMAL);
strings_bank_ref = fmod_studio_system_load_bank_file(fmod_path_bundle("Desktop//Master.strings.bank"), FMOD_STUDIO_LOAD_BANK.NORMAL);
ambienceBankRef = fmod_studio_system_load_bank_file(fmod_path_bundle("Desktop//Ambience.bank"), FMOD_STUDIO_LOAD_BANK.NORMAL);
ambienceBankRef = fmod_studio_system_load_bank_file(fmod_path_bundle("Desktop//SFX.bank"), FMOD_STUDIO_LOAD_BANK.NORMAL);
eventB = fmod_studio_system_get_event("event:/basilicaAmbience");
eventBasilicaAmbience = fmod_studio_event_description_create_instance(eventB);
eventLidarEngaged = fmod_studio_system_get_event("event:/lidarTimer");
eventLidarEngagedI = fmod_studio_event_description_create_instance(eventLidarEngaged);
eventRotWheel = fmod_studio_system_get_event("event:/RotationWheelTurned");
eventRotWheelInst = fmod_studio_event_description_create_instance(eventRotWheel);
eventGroan = fmod_studio_system_get_event("event:/hullGroans");
eventGroanInst = fmod_studio_event_description_create_instance(eventGroan);

activeServices = array_create(0)
#endregion



/**
 * Creates an Audio Service manager for the given event. Customizeable updates and kill toggles can also be supplied
 * @param {event_instance_ref} audioEvent The FMOD Event Instance to manage
 * @param {any*} updateFunc A function that is called every update tick. Updates are passed the Event Instance
 * @param {any*} stateFunc A function that handles termination of an Audio Service. The Audio Service will be terminated when this function returns true.
 */
function play(audioEvent,updateFunc, stateFunc){
		
		array_insert(activeServices,0,{event:audioEvent,update:updateFunc,state:stateFunc})
}

function playStep(service){
	
		service.update(service.event)
		return service.state(service.event)
}


#region Object Services
#region Lidar Audio Service
function updateLidarSound(event) {
		if ShipMaster.shipStatus.sonarLidar.lidarScanning{
			if fmod_studio_event_instance_get_playback_state(event) == FMOD_STUDIO_PLAYBACK_STATE.STOPPED {
				fmod_studio_event_instance_start(event)
			}
			fmod_studio_event_instance_set_parameter_by_name(event, "lidarEngaged", 1)
		}
		else
			fmod_studio_event_instance_set_parameter_by_name(event, "lidarEngaged", 0)
			
}

function killLidarSound(event) {
		return false
}
	
AudioService.play(AudioService.eventLidarEngagedI,updateLidarSound,killLidarSound)
#endregion
#region Ambience Audio Service
function updateAmbience(event) {
	if ShipMaster.shipStatus.digestive.running and ShipMaster.shipStatus.sonarLidar.sonarLidarSwitchEngaged and fmod_studio_event_instance_get_playback_state(event) == FMOD_STUDIO_PLAYBACK_STATE.STOPPED
		fmod_studio_event_instance_start(event)
	if ShipMaster.shipStatus.sonarLidar.sonarLidarSwitchEngaged and fmod_studio_event_instance_get_paused(event) == true
		fmod_studio_event_instance_set_paused(event,0)
	var distanceToWind = point_distance(ShipMaster.posx,ShipMaster.posy,2000,624)/1400
	var distanceToHall = point_distance(ShipMaster.posx,ShipMaster.posy,2400,3500)/2800
	if distanceToWind < distanceToHall{
		fmod_studio_event_instance_set_parameter_by_name(event,"Location", 0)
		fmod_studio_event_instance_set_parameter_by_name(event,"dtOutside", distanceToWind)
	}else {
		fmod_studio_event_instance_set_parameter_by_name(event,"Location", 1)
		fmod_studio_event_instance_set_parameter_by_name(event,"dtOutside", distanceToWind)
}
			
}

function killAmbience(event) {
	
		if !(ShipMaster.shipStatus.digestive.running and ShipMaster.shipStatus.sonarLidar.sonarLidarSwitchEngaged){
			fmod_studio_event_instance_set_paused(event,1)
			return false
		}
}

AudioService.play(AudioService.eventBasilicaAmbience,updateAmbience, killAmbience)
#endregion
#region Wheel Audio Service
function updateWheelSound(event) {
	if fmod_studio_event_instance_get_playback_state(event) == FMOD_STUDIO_PLAYBACK_STATE.STOPPED
		fmod_studio_event_instance_start(event)
	if instance_exists(oNavRotation)
		var rot = oNavRotation.rotv
	else
		var rot = ShipMaster.shipStatus.sonarLidar.rotationWheel
	if abs(rot/10) > 0.3 and fmod_studio_event_instance_get_playback_state(AudioService.eventGroanInst) == FMOD_STUDIO_PLAYBACK_STATE.STOPPED
		fmod_studio_event_instance_start(AudioService.eventGroanInst)

	fmod_studio_system_set_parameter_by_name("rotationVelocity",rot/10)
	
			
}

function killWheel(event) {
	
		return false
}
AudioService.play(AudioService.eventRotWheelInst,updateWheelSound, killWheel)
#endregion
#endregion

