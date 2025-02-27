x = 828
y = 232

hand1 = {
	a:ShipMaster.shipStatus.sonarLidar.dappPos[0],
	dist:0,
	x:0,
	y:0
}

hand2 = {
	a:ShipMaster.shipStatus.sonarLidar.dappPos[1],
	dist:0,
	x:0,
	y:0
}


lastPts=[0,0]
mouseVPos = {x:0,y:0}

lastHand = 0
updateRate = 1
frame = 0



hand1.x = x + lengthdir_x(100,hand1.a+90)
hand1.y = y + lengthdir_y(100,hand1.a+90)
hand2.x = x + lengthdir_x(100,hand2.a+90)
hand2.y = y + lengthdir_y(100,hand2.a+90)

fidelity = 0
grain = 5
maxDist = 400

function grabDist(hand){

	_scandeg = hand.a + ShipMaster.angle+90
	
	
	
	var _fidelity = random(grain*fidelity*2)-fidelity
	
	var _grain = grain + _fidelity

	var _x = lengthdir_x(_grain,_scandeg)
	var _y = lengthdir_y(_grain,_scandeg)

		
	var px = ShipMaster.posx
	var py = ShipMaster.posy
	
	var fail = true
	for(var i=0; i<maxDist/_grain;i++){
		px += _x
		py += _y
				
				
	
		var rayPoint = getPixelFromBuffer(global.currMapBuffer,px,py)

		
		if(rayPoint.r){
			hand.dist = i*_grain
			fail = false
			break
		}

		
	}
	
	if fail
		hand.dist = maxDist

	

	
	
}

