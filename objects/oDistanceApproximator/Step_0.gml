
var m1Dir = 0
if global.mouse_occupied == "hand1" {
	
	var mDir = hand1.a
	
	hand1.a += (global.mouseY-mouseVPos.y)/4	
	hand1.a = clamp(hand1.a,30,170)
	
	window_mouse_set(mouseVPos.x,mouseVPos.y)

		m1Dir = abs(mDir - hand1.a)
	hand1.x = x + lengthdir_x(100,hand1.a+90)
	hand1.y = y + lengthdir_y(100,hand1.a+90)
}

var m2Dir = 0
if global.mouse_occupied == "hand2" {
	var mDir = hand2.a
	hand2.a -= (global.mouseY-mouseVPos.y)/4	

	if sign(hand2.a) == -1
		hand2.a += 360
	hand2.a = clamp(hand2.a,190,330)	
	
	
	m2Dir = abs(mDir - hand2.a)
		
	hand2.x = x + lengthdir_x(100,hand2.a+90)
	hand2.y = y + lengthdir_y(100,hand2.a+90)
	window_mouse_set(mouseVPos.x,mouseVPos.y)
}

if abs(ShipMaster.shipStatus.sonarLidar.rotationWheel) > random(0.2)
	updateRate = max(updateRate,abs(ShipMaster.shipStatus.sonarLidar.rotationWheel))
	

updateRate = max(0,abs(ShipMaster.shipStatus.sonarLidar.rotationWheel)/0.4,abs(ShipMaster.forwardv),m1Dir,m2Dir)*100
updateRate = ceil(updateRate)

//print(0,abs(ShipMaster.shipStatus.sonarLidar.rotationWheel)/0.4,abs(ShipMaster.forwardv),m1Dir,m2Dir)

grabDist(hand1)
grabDist(hand2)

