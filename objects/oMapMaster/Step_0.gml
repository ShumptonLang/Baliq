if ControllerService.shipStatus.map.scanningState == "prune" {
	if array_length(ControllerService.shipStatus.map.navPath) < 2 {
		ControllerService.shipStatus.map.scanningState = "off"	
	}
	else 
	{
		var equalNavPath = array_create(1,ControllerService.shipStatus.map.navPath[0])
		var currentPoint = ControllerService.shipStatus.map.navPath[0]
	
		for (var i = 0; i < array_length(ControllerService.shipStatus.map.navPath); i++) {
			if point_distance(currentPoint.x,currentPoint.y,ControllerService.shipStatus.map.navPath[i].x,ControllerService.shipStatus.map.navPath[i].y) > 50 {
				array_insert(equalNavPath,0,ControllerService.shipStatus.map.navPath[i])
				currentPoint = ControllerService.shipStatus.map.navPath[i]
			}
		}
	
		ControllerService.shipStatus.map.navPath = equalNavPath
		ControllerService.shipStatus.map.scanningState = "travelStart"
		
		
		var target = ControllerService.shipStatus.map.navPath[0]
		var target2 = ControllerService.shipStatus.map.navPath[1]
		ShipMaster.queueMovement(ShipMaster.orientToPoint,[target.x,target.y], 0,10)
		ShipMaster.queueMovement(ShipMaster.navToPoint,[target.x,target.y], 0,20)
		ShipMaster.queueMovement(ShipMaster.orientToPoint,[target2.x,target2.y], 0,10,ShipMaster.navPath)	


	}
}

if ControllerService.shipStatus.map.scanningState == "travelStart" {
		if point_distance(ShipMaster.posx,ShipMaster.posy,ControllerService.shipStatus.map.navPath[0].x,ControllerService.shipStatus.map.navPath[0].y) < 20 {
			
			
			
			ControllerService.shipStatus.map.scanningState = "off"
		}
}

	
mapYOffset = ControllerService.shipStatus.map.printerOffset

currMapX = mapXOrigin + mapXOffset
currMapY = mapYOrigin + mapYOffset