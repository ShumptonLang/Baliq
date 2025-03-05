// Inherit the parent event
event_inherited();

is_interactive = true;
interaction_priority = 10;
interaction_shape = "custom"; // or "circle" or "custom"


inkBounds = {x:1267,y:68,_x : 1317,_y:118}
ink_dims = 50
colors = [c_green,c_blue,c_yellow,c_red,c_orange,c_aqua,c_fuchsia,c_black]

palleteDims = [4,2]

function on_interaction_start() {
	var _x = oInputManager.mouse_x_gui	
	var _y = oInputManager.mouse_y_gui
	
	_x = floor((_x - inkBounds.x)/50)
	_y = floor((_y - inkBounds.y)/50)
	
	oMapMaster.current_color = colors[_x*4+_y]
	audio_play_sound(squish,0,0)
}

function interaction_contains_point(x, y) {
    var _x = x - inkBounds.x
	var _y = y - inkBounds.y
	
	//print(ceil(_x/ink_dims/palleteDims[1]) == 1 and ceil(_y/ink_dims/palleteDims[0]) == 1)
    return ceil(_x/ink_dims/palleteDims[1]) == 1 and ceil(_y/ink_dims/palleteDims[0]) == 1;
}




