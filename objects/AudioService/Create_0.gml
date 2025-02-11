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

function play(audioEvent,updateFunc, stateFunc){
		
		array_insert(activeServices,0,{event:audioEvent,update:updateFunc,state:stateFunc})
}

function playStep(service){
	
		service.update(service.event)
		if service.state(service.event){
			print ("Toast")
			fmod_studio_event_instance_stop(service.event)
		}
}