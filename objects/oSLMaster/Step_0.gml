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

if array_length(navPath) > 2 {
	for (var i = 0; i < array_length(navPath); i++ ){
		var dist = point_distance(ShipMaster.posx,ShipMaster.posy,navPath[i].x,navPath[i].y)
	
		if dist < closestDist {
			closestDist = dist
			closestPointIdx = i
		}
	}
	if closestPointIdx == array_length(navPath)-2{
		ControllerService.shipStatus.ship.navigationState = "none"	
		ControllerService.shipStatus.sonarLidar.emergingToolAlpha = 0
		ControllerService.shipStatus.map.navPath = array_create(0)
	}

	if closestPointIdx < array_length(navPath)-2 {
		var currPoint = navPath[closestPointIdx]
		var nextPoint = navPath[closestPointIdx+1]
		var nextNextPoint = navPath[closestPointIdx+2]
		
		var currLineDist = point_distance(currPoint.x,currPoint.y,nextPoint.x,nextPoint.y)
		var currLineAngle = point_direction(currPoint.x,currPoint.y,nextPoint.x,nextPoint.y)
		
		var shipLineAngle = angle_difference(ShipMaster.angle,currLineAngle)
		var currShipDist = point_distance(currPoint.x,currPoint.y,ShipMaster.posx,ShipMaster.posy)
		
		var dot = currShipDist*dcos(shipLineAngle) 
		
		var pct = dot/currLineDist
		
		var nextLineDist = point_distance(nextPoint.x,nextPoint.y,nextNextPoint.x,nextNextPoint.y)
		var nextLineAngle = point_direction(nextPoint.x,nextPoint.y,nextNextPoint.x,nextNextPoint.y)
		
		var targetPoint = {x:lengthdir_x(nextLineDist*pct,nextLineAngle)+nextPoint.x,y:lengthdir_y(nextLineDist*pct,nextLineAngle)+nextPoint.y}
		debugTargetPoint = targetPoint
		print(targetPoint)
		var shipTargetAngle = point_direction(ShipMaster.posx,ShipMaster.posy,targetPoint.x,targetPoint.y)
		var error = angle_difference(ShipMaster.angle,shipTargetAngle)
		pathingError = error
	}
}



	






