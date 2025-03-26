
var _x = lengthdir_x(1,self.angle)
var _y = lengthdir_y(1,self.angle)



forwardA = forwardV +forwardFrict*forwardA

self.posy += _y*forwardV
self.posx += _x*forwardV

forwardV *=0.95
rotationV *=0.95

self.angle += rotationV

contact = getPixelFromBuffer(global.currMapBuffer,posx-_x*30,posy-_y*30).r 


if contact  {
	contact = false

	stopNavPath(true)
	ds_queue_clear(movementQueue)
	ControllerService.shipStatus.map.navPath = array_create(0)
	
	
	self.posy -= _y *5
	self.posx -= _x * 5
	forwardV = -forwardV*2	
	audio_play_sound(collision,1,0,ControllerService.shipStatus.ship.velocity*3,0,1)
}



if isNavvingPath {
	var pathNodeCount = array_length(ControllerService.shipStatus.map.navPath)
	
	pathNavCurr += pathNavSpeed / 60
	
	var pctDone = pathNavCurr/pathDist
	
	
	var currNodeIdx = floor(pathNodeCount*pctDone)
	var currLinePct = frac(pathNodeCount*pctDone)
	
	ControllerService.shipStatus.ship.velocity = 1 - abs(pathCDF[currNodeIdx])
	
	print(pathNavCurr,pathDist,pctDone, ControllerService.shipStatus.ship.velocity)
	
	var currNode = ControllerService.shipStatus.map.navPath[currNodeIdx]
	var nextNode = ControllerService.shipStatus.map.navPath[currNodeIdx+1]
	
	if currNodeIdx == array_length(ControllerService.shipStatus.map.navPath)-2{
		stopNavPath(true)
	}
	
	var lineAngle = point_direction(currNode.x,currNode.y,nextNode.x,nextNode.y)
	var lineDist = point_distance(currNode.x,currNode.y,nextNode.x,nextNode.y)
	posx = currNode.x + lengthdir_x(lineDist*currLinePct,lineAngle)
	posy = currNode.y + lengthdir_y(lineDist*currLinePct,lineAngle)
	angle = lineAngle
	

}
else {
	ControllerService.shipStatus.ship.velocity = 0
}

if ds_queue_size(movementQueue) != 0 {
	var currentQueuedMovement = ds_queue_head(movementQueue)
	var currVal = script_execute_ext(currentQueuedMovement[0],currentQueuedMovement[1])
	print(ds_queue_size(movementQueue),currVal,currentQueuedMovement[2],currentQueuedMovement[3])
	
	if median(currVal,currentQueuedMovement[2],currentQueuedMovement[3]) == currVal	{
		var deadMovement = ds_queue_dequeue(movementQueue)
		deadMovement[4]()
	}
		
}

var dX = posx-lastPosX
var dY = posy-lastPosY

if avgVelocityTimer >= avtUpdateRate {
	
	var currVelocity = sqrt(sqr(dX)+sqr(dY))
	array_shift(avgVelocityHistory)
	array_push(avgVelocityHistory,currVelocity)
	
	avgVelocityTimer %= avtUpdateRate
}



if avgRotationTimer >= artUpdateRate {
	
	avgRotationTimer = 0
}



avgRotationTimer += delta_time/1000000
avgVelocityTimer += delta_time/1000000


//if keyboard_check_released(vk_space){
//	ControllerService.shipStatus.map.navPath = chaikin(ControllerService.shipStatus.map.navPath)	
//}

//if keyboard_check_released(vk_backspace){
//	ControllerService.shipStatus.map.navPath = anglePrune(ControllerService.shipStatus.map.navPath,5)	
//}


var sum = 0
for (var i = 0; i < array_length(avgVelocityHistory); i++) {
	sum += avgVelocityHistory[i]	
}
//ControllerService.shipStatus.ship.velocity = sum/avgVelocityAmt/avtUpdateRate




//print(avgVelocityHistory,sum/avgVelocityAmt)


if keyboard_check_pressed(vk_numpad0)
	shipStatus.digestive.running = true
//print(rotv)

lastPosX = posx
lastPosY = posy