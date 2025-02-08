//The Job of the ShipMaster is to hold all statuses of each object

global.mouse_occupied = 0
global.mouse_occupied_changed = false
lastMOccupiedInterim = 0
global.lastMouseOccupied = 0
global.currMapBuffer = -1
global.noiseBuffer = -1

shipStatus = {
	sonarLidar: {
		sonarScanning : false,
		sonarLidarSwitchEngaged : false,
		sonarScanTime : 0,
		
		lidarScanning: false,
		lidarScanTime: false
	}, 
	digestive: {
		running: false,
		compSwitchPositions : [0,0,0,0],
		ignitionState : "sleeping",
		ignitionSwitchStates : [4,3,4,2,1],
		waterVolume : 0.0
	}
}


//bank_ref = fmod_studio_system_load_bank_file(fmod_path_bundle("Desktop\\Master.bank"), FMOD_STUDIO_LOAD_BANK.NORMAL);
//strings_bank_ref = fmod_studio_system_load_bank_file(fmod_path_bundle("Desktop\\Master.strings.bank"), FMOD_STUDIO_LOAD_BANK.NORMAL);
//SFXBankRef = fmod_studio_system_load_bank_file(fmod_path_bundle("Desktop\\SFX.bank"), FMOD_STUDIO_LOAD_BANK.NORMAL);
bank_ref = fmod_studio_system_load_bank_file(fmod_path_bundle("Desktop//Master.bank"), FMOD_STUDIO_LOAD_BANK.NORMAL);
strings_bank_ref = fmod_studio_system_load_bank_file(fmod_path_bundle("Desktop//Master.strings.bank"), FMOD_STUDIO_LOAD_BANK.NORMAL);
ambienceBankRef = fmod_studio_system_load_bank_file(fmod_path_bundle("Desktop//Ambience.bank"), FMOD_STUDIO_LOAD_BANK.NORMAL);
eventB = fmod_studio_system_get_event("event:/basilicaAmbience");

eventBasilicaAmbience = fmod_studio_event_description_create_instance(eventB);



randomize()