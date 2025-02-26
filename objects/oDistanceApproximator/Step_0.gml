if global.mouse_occupied == "hand1" {
	
	var mDir = hand1.a
	
	hand1.a = clamp(point_direction(x,y,global.mouseX,global.mouseY)-90,30,170)	
	
	if abs(mDir - hand1.a) > 0.25
		updateDist = true
	hand1.x = x + lengthdir_x(100,hand1.a+90)
	hand1.y = y + lengthdir_y(100,hand1.a+90)
}

if global.mouse_occupied == "hand2" {
	var mDir = hand2.a
	hand2.a = point_direction(x,y,global.mouseX,global.mouseY)-90
	if sign(hand2.a) == -1
		hand2.a += 360
	hand2.a = clamp(hand2.a,190,330)	
	
	if abs(mDir - hand2.a) > 0.25
		updateDist = true
		
	hand2.x = x + lengthdir_x(100,hand2.a+90)
	hand2.y = y + lengthdir_y(100,hand2.a+90)
}

if abs(ShipMaster.shipStatus.sonarLidar.rotationWheel) > random(0.2)
	updateDist = true
	
if abs(ShipMaster.forwardv) > random(0.2)
	updateDist = true

grabDist(hand1)
grabDist(hand2)

