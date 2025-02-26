//if ShipMaster.shipStatus.digestive.running{
//	if fmod_studio_event_instance_get_playback_state(ShipMaster.eventBasilicaAmbience) == FMOD_STUDIO_PLAYBACK_STATE.STOPPED
//		fmod_studio_event_instance_start(ShipMaster.eventBasilicaAmbience)
//	fmod_studio_event_instance_set_volume(ShipMaster.eventBasilicaAmbience,1) 
//}
//else {
//	fmod_studio_event_instance_set_volume(ShipMaster.eventBasilicaAmbience,0) 
//}




#region Timers
if master.getValue("sonarLidar", "sonarScanTime") >= waitSonarLength{

	updateStatus("sonarEngaged",false)
	
}


#endregion

#region Sonar cull available points for rendering
var mapPointX = round(ShipMaster.posx / chunkSize)*chunkSize
var mapPointY = round(ShipMaster.posy / chunkSize)*chunkSize


var lookupRange = 4
if global.debug  updateLidar()

//print(getPixelFromBuffer(global.currMapBuffer,ShipMaster.posx,ShipMaster.posy))

//Update pointsToRender 
for (var i = 0; i < 2*lookupRange+1; i++) {
		for (var j = 0; j < 2*lookupRange+1; j++){
				
				var cellPos = string((i-lookupRange)*chunkSize + mapPointX) + "." + string((j-lookupRange)*chunkSize + mapPointY)
				var cellPosHash = variable_get_hash(cellPos)
				var cellArray = struct_get_from_hash(pointMap,cellPosHash)
				
				if array_length(cellArray) > 0{
					pointsToRender = array_concat(pointsToRender,cellArray)	
					//print(cellArray)
					
				}
				
				
		}
}


//Apply modifications to pointsToRender

for( var k = 0; k < array_length(pointsToRender); k++){
					

					var screenSrc = screenPos(pointsToRender[k].x, pointsToRender[k].y,global.sonarSurf);

					var normPos = normalizeToCenter(screenSrc,global.sonarSurf)
					
					var angle = point_direction(720,540,normPos.x,normPos.y) +ShipMaster.angle
					
					pointsToRender[k].degree = angle
					//print(angle)

					//print(normPos)
					normPos = screen2clip(normPos.x,normPos.y)
					pointsToRender[k].norm = normPos
					//print(normPos)
					
					var siltImpact = pointsToRender[k].material.g / 255
					
					var warpMin = 1 - siltImpact/10
					var warpMax = 1 + siltImpact/10
					
					
					var warpMult = (warpMax-warpMin)
					
					normPos.x *= warpMult * (dsin(5*angle+current_time/10)/2) + warpMin
					normPos.y *= warpMult * (dsin(5*angle+current_time/20)/2) + warpMin
					
					warpMin = 1 - siltImpact/20
					warpMax = 1 + siltImpact/15

					warpMult = (warpMax-warpMin)
					
					normPos.x *= warpMult * (dsin(20*angle-current_time/30)/2) + warpMin
					normPos.y *= warpMult * (dsin(20*angle-current_time/10)/2) + warpMin
					
					var warpColor = ((1-abs(dcos(5*angle+current_time/100)))*3)
					warpColor = max(warpColor,0)

					
					//normPos.x *= random_range(0.9,1.1)
					//normPos.y *= random_range(0.9,1.1)
					//print(normPos)
					normPos = clip2screen(normPos.x,normPos.y)
					//print(normPos)
					//var distTo = 255/(point_distance(cellArray[k].tempX, cellArray[k].tempY,cellArray[k+1].tempX,cellArray[k+1].tempY))*10
					//var distFrom = 255/(point_distance(cellArray[k].tempX, cellArray[k].tempY,cellArray[k-1].tempX,cellArray[k-1].tempY))*10
					//var dist = min(min(distTo,distFrom),0)
					var distShip = 255/power(point_distance(pointsToRender[k].x, pointsToRender[k].y,ShipMaster.posx,ShipMaster.posy),3)*50000
					var dist = distShip+(warpColor*siltImpact) + (1-siltImpact)*2
					
					pointsToRender[k].displayX = normPos.x
					pointsToRender[k].displayY = normPos.y
					pointsToRender[k].lumin = dist
}
array_sort(pointsToRender,function(elm1, elm2){
						return elm1.degree - elm2.degree;	
					});
#endregion



	






