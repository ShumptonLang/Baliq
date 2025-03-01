x = 828
y = 232

hand1 = {
	a:90,
	scanA:90,
	dist:0,
	x:0,
	y:0,
	frame:0,
	id:0,
	lastPointPos: {x:0,y:0},
	fail:0
}

hand2 = {
	a:270,
	scanA:90,
	dist:0,
	x:0,
	y:0,
	frame:0,
	id:1,
	lastPointPos: {x:0,y:0},
	fail:0
}


lastPts=[0,0]
mouseVPos = {x:0,y:0}

lastHand = 0
updateRate = 1
sweepAngle = 300



hand1.x = x + lengthdir_x(100,hand1.a+90)
hand1.y = y + lengthdir_y(100,hand1.a+90)
hand2.x = x + lengthdir_x(100,hand2.a+90)
hand2.y = y + lengthdir_y(100,hand2.a+90)

fidelity = 0
grain = 1
maxDist = 200

function grabDist(hand){

	var _scandeg = (hand.frame-sweepAngle/2)* power(-1,1-hand.id)

	var scanPos = {x:_scandeg *ShipMaster.forward.x+ShipMaster.posx, y: _scandeg*ShipMaster.forward.y+ShipMaster.posy}
	var normDir = {x:lengthdir_x(1,ShipMaster.angle+hand.id*180),y:lengthdir_y(1,ShipMaster.angle+hand.id*180)}
	
	var _fidelity = random(grain*fidelity*2)-fidelity
	
	var _grain = grain + _fidelity

	

	var fail = true
	for(var i=0; i<maxDist;i++){
		var sampX = scanPos.x - i*normDir.x
		var sampY = scanPos.y - i*normDir.y
				
				
	
		var rayPoint = getPixelFromBuffer(global.currMapBuffer,sampX,sampY)

		
		if(rayPoint.r){
			hand.dist = i*_grain
			hand.lastPointPos.x = sampX
			hand.lastPointPos.y = sampY
			hand.fail = 0
			fail = false
			break
		}

		
	}
	
	if fail
		hand.fail = 1



	
}
	
function grabDistWorking(hand){

	_scandeg = hand.scanA + ShipMaster.angle+90
	
	
	
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

