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

var navPath = ControllerService.shipStatus.map.navPath

var closestPointIdx = -1
var closestDist = 1000000

if array_length(navPath) > 1 {
	for (var i = 0; i < array_length(navPath); i++ ){
		var dist = point_distance(ShipMaster.posx,ShipMaster.posy,navPath[i].x,navPath[i].y)
	
		if dist < closestDist {
			closestDist = dist
			closestPointIdx = i
		}
	}
	if closestPointIdx == array_length(navPath)-1{
		ControllerService.shipStatus.ship.navigationState = "none"	
	}

	if closestPointIdx != array_length(navPath)-1 {
		var nextPoint = navPath[closestPointIdx+1]
		var pointAngle = point_direction(ShipMaster.posx,ShipMaster.posy,nextPoint.x,nextPoint.y)

		pathingError = angle_difference(pointAngle,ShipMaster.angle)
	}
}



	






