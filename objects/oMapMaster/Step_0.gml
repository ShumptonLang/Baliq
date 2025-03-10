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
	startingAngle = angle_difference(ShipMaster.angle , point_direction(ShipMaster.posx,ShipMaster.posy,navPath[0].x,navPath[0].y))
}


if state.scanningState == "travelStart" and array_length(navPath) > 0{
	var target = navPath[0]
	var pctDone = ShipMaster.orientToPoint(target.x,target.y,startingAngle)
	
	if pctDone >=0.99 {
		ShipMaster.navToPoint(target.x,target.y)	
	}
	
}

if state.scanningState == "preOrient" {
	var target = navPath[0]
	var target2 = navPath[1]
	//var angleDiff = angle_difference(ShipMaster.angle , point_direction(ShipMaster.posx,ShipMaster.posy,target.x,target.y))
	var angleDiff = angle_difference(ShipMaster.angle , point_direction(target.x,target.y,target2.x,target2.y))
	var distToTarget = point_distance(ShipMaster.posx,ShipMaster.posy,target.x,target.y)
	print(angleDiff)
	
	var time2Pos = distToTarget/maxV
	var time2Rot = abs(angleDiff)/rotateMaxV
	
	var scaler = max(time2Pos,time2Rot)
	
	v = distToTarget/scaler
	rotateV = angleDiff/scaler*sign(angleDiff)
	
	ShipMaster.shipStatus.sonarLidar.forwardLever /= 2
	ShipMaster.angle += rotateV
	
}