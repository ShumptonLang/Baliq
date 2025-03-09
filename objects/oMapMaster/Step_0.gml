if state.scanningState == "prune" {
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
}


if state.scanningState == "travelStart" and array_length(navPath) > 0{
	var target = navPath[0]
	var angleDiff = angleDifference(ShipMaster.angle , point_direction(ShipMaster.posx,ShipMaster.posy,target.x,target.y))	
	print(angleDiff)
	if angleDiff.angle > 30 {
		rotateV += (rotateMaxV - rotateV)/2
	} 
	if angleDiff.angle < 30  {
		rotateV = (0 + rotateV)/2
	}
	if point_distance(ShipMaster.posx,ShipMaster.posy,target.x,target.y) < 20 {
		state.scanningState = "preOrient"
	}
	
	if angleDiff.angle < 60 {
		ShipMaster.shipStatus.sonarLidar.forwardLever = (ShipMaster.shipStatus.sonarLidar.forwardLever + 1)/2
	}
	
	ShipMaster.angle += rotateV
}

if state.scanningState == "preOrient" {
	var target = navPath[0]
	var target2 = navPath[1]
	var angleDiff = angleDifference(ShipMaster.angle , point_direction(target.x,target.y,target2.x,target2.y))	
	print("PreOrient", angleDiff, array_length(navPath))
	if angleDiff.angle > 1 {
		if true
			ShipMaster.angle += 1
		else
			ShipMaster.angle -= 1
	}


	ShipMaster.shipStatus.sonarLidar.forwardLever = (ShipMaster.shipStatus.sonarLidar.forwardLever)/2
	
}