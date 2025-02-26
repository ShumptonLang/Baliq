x = 828
y = 232

hand1 = {
	a:150,
	dist:0,
	x:0,
	y:0
}

hand2 = {
	a:20,
	dist:0,
	x:0,
	y:0
}




lastHand = 0
updateDist = false




hand1.x = x + lengthdir_x(100,hand1.a)
hand1.y = y + lengthdir_y(100,hand1.a)
hand2.x = x + lengthdir_x(100,hand2.a)
hand2.y = y + lengthdir_y(100,hand2.a)

fidelity = 0
grain = 20
maxDist = 800

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

