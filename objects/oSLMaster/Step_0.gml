if ShipMaster.SLPower{
	if fmod_studio_event_instance_get_playback_state(ShipMaster.eventBasilicaAmbience) == FMOD_STUDIO_PLAYBACK_STATE.STOPPED
		fmod_studio_event_instance_start(ShipMaster.eventBasilicaAmbience)
	fmod_studio_event_instance_set_volume(ShipMaster.eventBasilicaAmbience,1) 
}
else {
	fmod_studio_event_instance_set_volume(ShipMaster.eventBasilicaAmbience,0) 
}

