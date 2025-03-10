if gameStarting {
	if instance_exists(oInputManager) and instance_exists(FMODManager)	{
		gameStarting = false
		room_goto(Cockpit)
	}
}







var _x = lengthdir_x(1,self.angle)
var _y = lengthdir_y(1,self.angle)


//forwardV += (-maxForwardV*forwardV- forwardV)


self.posy += _y*forwardV
self.posx += _x*forwardV

self.angle += rotationV

contact = getPixelFromBuffer(global.currMapBuffer,posx-_x*30,posy-_y*30).r 
//print(contact)
if contact and false {
	contact = false
	self.posy += _y *5
	self.posx += _x * 5
	forwardV = -forwardV	
	audio_play_sound(collision,1,0,abs(forwardV)*5,0,1)
}


//print(room_get_name(room))



for (var i = 0; i < array_length(timers); i++){
	var timer = array_shift(timers)
	timer.timerCurrentValue += delta_time / 1000000
	if timer.timerCurrentValue >= timer.goal {
		timer.timerCurrentValue = 0
		timer.goalFunc()
	} else {
		array_push(timers,timer)
		timer.update(timer.timerCurrentValue)
	}
}


//print(shipStatus.sonarLidar)
//print(AudioService.activeServices)

if keyboard_check_pressed(vk_numpad0)
	shipStatus.digestive.running = true
//print(rotv)

forwardPct -= 0.01
rotationPct -= 0.001