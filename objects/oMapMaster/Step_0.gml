if state.scanningState == "prune" {
	if array_length(navPath) < 2 {
		state.scananingState = "off"	
	}
	else 
	{
		var equalNavPath = array_create(1,navPath[0])
		var currentPoint = navPath[0]
	
		for (var i = 0; i < array_length(navPath); i++) {
			if point_distance(currentPoint.x,currentPoint.y,navPath[i].x,navPath[i].y) > 50 {
				array_insert(equalNavPath,0,navPath[i])
				currentPoint = navPath[i]
			}
		}
	
		navPath = equalNavPath
		state.scanningState = "travelStart"
		startingAngle = angle_difference(ShipMaster.angle , point_direction(ShipMaster.posx,ShipMaster.posy,navPath[0].x,navPath[0].y))
		
		var target = navPath[0]
		ShipMaster.queueMovement(ShipMaster.orientToPoint,[target.x,target.y,startingAngle], 0.99,1)
		ShipMaster.queueMovement(ShipMaster.navToPoint,[target.x,target.y], 0,20)

	}
}

if state.scanningState == "travelStart" {
		if point_distance(ShipMaster.posx,ShipMaster.posy,navPath[0].x,navPath[0].y) < 20 {
			
			var target = navPath[1]
			startingAngle = angle_difference(ShipMaster.angle , point_direction(ShipMaster.posx,ShipMaster.posy,navPath[1].x,navPath[1].y))
			ShipMaster.queueMovement(ShipMaster.orientToPoint,[target.x,target.y,startingAngle], 0.99,1, finalizeOrientation)	
			
			state.scanningState = "off"
		}
}

	
mapYOffset = oScanner.mapOffset

currMapX = mapXOrigin + mapXOffset
currMapY = mapYOrigin + mapYOffset