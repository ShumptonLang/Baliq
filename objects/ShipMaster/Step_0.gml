self.angle += rotv
self.angle = (self.angle + 360) % 360

global.mouse_occupied_changed = lastMOccupiedInterim != global.mouse_occupied
global.lastMouseOccupied = lastMOccupiedInterim
lastMOccupiedInterim = global.mouse_occupied

var _x = lengthdir_x(1,self.angle-90)
var _y = lengthdir_y(1,self.angle-90)

forwardv += (-maxv*forward_normal - forwardv)*0.005
if(forward_normal == 0) forwardv *= 0.99

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

//debug_sprite_memory()
//debug_texture_pages()



//print(rotv)