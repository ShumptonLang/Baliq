self.angle -= shipStatus.sonarLidar.rotationWheel
self.angle = (self.angle + 360) % 360

global.mouse_occupied_changed = lastMOccupiedInterim != global.mouse_occupied
global.lastMouseOccupied = lastMOccupiedInterim
lastMOccupiedInterim = global.mouse_occupied

var _x = lengthdir_x(1,self.angle-90)
var _y = lengthdir_y(1,self.angle-90)

forwardv += (-maxv*shipStatus.sonarLidar.forwardLever - forwardv)*0.005
if(shipStatus.sonarLidar.forwardLever == 0) forwardv *= 0.95

self.posy += _y*forwardv
self.posx += _x*forwardv

contact = getPixelFromBuffer(global.currMapBuffer,posx-_x*30,posy-_y*30).r
//print(contact)
if contact {
	contact = false
	self.posy += _y *5
	self.posx += _x * 5
	forwardv = -forwardv	
	audio_play_sound(collision,1,0,abs(forwardv)*5,0,1)
}

global.mouseX = device_mouse_x_to_gui(0)
global.mouseY = device_mouse_y_to_gui(0)

//print(room_get_name(room))
fmod_studio_system_set_parameter_by_name("shiplocation", room)
var distanceToWind = point_distance(posx,posy,2000,624)/1400
var distanceToHall = point_distance(posx,posy,2400,3500)/2800
//if distanceToWind < distanceToHall{
//	fmod_studio_event_instance_set_parameter_by_name(eventBasilicaAmbience,"Location", 0)
//	fmod_studio_event_instance_set_parameter_by_name(eventBasilicaAmbience,"dtOutside", distanceToWind)
//}else {
//	fmod_studio_event_instance_set_parameter_by_name(eventBasilicaAmbience,"Location", 1)
//	fmod_studio_event_instance_set_parameter_by_name(eventBasilicaAmbience,"dtOutside", distanceToWind)
//}


//if shipStatus.digestive.running and fmod_studio_event_instance_get_playback_state(eventBasilicaAmbience) == FMOD_STUDIO_PLAYBACK_STATE.STOPPED
//	fmod_studio_event_instance_start(eventBasilicaAmbience)



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