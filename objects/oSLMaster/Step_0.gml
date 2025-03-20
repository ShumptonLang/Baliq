//if ShipMaster.shipStatus.digestive.running{
//	if fmod_studio_event_instance_get_playback_state(ShipMaster.eventBasilicaAmbience) == FMOD_STUDIO_PLAYBACK_STATE.STOPPED
//		fmod_studio_event_instance_start(ShipMaster.eventBasilicaAmbience)
//	fmod_studio_event_instance_set_volume(ShipMaster.eventBasilicaAmbience,1) 
//}
//else {
//	fmod_studio_event_instance_set_volume(ShipMaster.eventBasilicaAmbience,0) 
//}





#region Sonar cull available points for rendering
var mapPointX = round(ShipMaster.posx / chunkSize)*chunkSize
var mapPointY = round(ShipMaster.posy / chunkSize)*chunkSize


var lookupRange = 4
if global.debug  updateLidar()







	






