if state.scanningState == "prune" {
	if array_length(navPath) < 2 {
		state.scanningState = "off"	
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
	}
}


if state.scanningState == "travelStart" and array_length(navPath) > 0{
	var target = navPath[0]
	var pctDone = ShipMaster.orientToPoint(target.x,target.y,startingAngle)
	var dist = 10000
	
	
	if pctDone >=0.99 {
		dist = ShipMaster.navToPoint(target.x,target.y)	
	}
	
	if dist < 20 {
		state.scanningState = "orient"
		startingAngle = angle_difference(ShipMaster.angle , point_direction(ShipMaster.posx,ShipMaster.posy,navPath[1].x,navPath[1].y))
	}
	
}

if state.scanningState == "orient" {
	print("orient")
	var target = navPath[1]
	var pctDone = ShipMaster.orientToPoint(target.x,target.y,startingAngle)
	
	if pctDone >= 0.99
		state.scanningState = "off"
	
}