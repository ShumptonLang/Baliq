self.angle += rotv
self.angle = (self.angle + 360) % 360

global.mouse_occupied_changed = lastMOccupiedInterim != global.mouse_occupied
global.lastMouseOccupied = lastMOccupiedInterim
lastMOccupiedInterim = global.mouse_occupied

var _x = lengthdir_x(1,self.angle-90)
var _y = lengthdir_y(1,self.angle-90)

forwardv += (-maxv*forward_normal - forwardv)*0.005
if(forward_normal == 0) forwardv *= 0.95

self.posy += _y*forwardv
self.posx += _x*forwardv

//print(contact)
if contact {
	contact = false
	self.posy += _y *5
	self.posx += _x * 5
	forwardv = -forwardv	
	audio_play_sound(collision,1,0,abs(forwardv)*5,0,1)
}

global.mouseX = window_mouse_get_x()
global.mouseY = window_mouse_get_y()

//print(room_get_name(room))
fmod_studio_system_set_parameter_by_name("shiplocation", room)
var distanceToWind = point_distance(posx,posy,2000,624)/1400
var distanceToHall = point_distance(posx,posy,2400,3500)/2800
if distanceToWind < distanceToHall{
	fmod_studio_event_instance_set_parameter_by_name(eventBasilicaAmbience,"Location", 0)
	fmod_studio_event_instance_set_parameter_by_name(eventBasilicaAmbience,"dtOutside", distanceToWind)
}else {
	fmod_studio_event_instance_set_parameter_by_name(eventBasilicaAmbience,"Location", 1)
	fmod_studio_event_instance_set_parameter_by_name(eventBasilicaAmbience,"dtOutside", distanceToWind)
}
print(distanceToWind,distanceToHall)
//print(fmod_studio_system_get_parameter_by_name("shiplocation"))
//print(fmod_last_result())

if shipStatus.digestive.running and fmod_studio_event_instance_get_playback_state(eventBasilicaAmbience) == FMOD_STUDIO_PLAYBACK_STATE.STOPPED
	fmod_studio_event_instance_start(eventBasilicaAmbience)
//print(fmod_last_result())

//debug_sprite_memory()
//debug_texture_pages()

print(shipStatus.sonarLidar)

//print(rotv)