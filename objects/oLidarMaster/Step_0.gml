//image_angle = 270-ship_master.angle
//sprite_set_offset(sprite_index, ship_master.posx, ship_master.posy)
camera_set_view_pos(view_camera[0], ship_master.posx-camera_get_view_width(view_camera[0])/2,ship_master.posy-camera_get_view_height(view_camera[0])/2)

camera_set_view_angle(view_camera[0],360-ship_master.angle)


var px = ship_master.posx
var py = ship_master.posy

var _fx = lengthdir_x(29,ship_master.angle+90)
var _fy = lengthdir_y(29,ship_master.angle+90)

if false {
var test_x = 744;
var test_y = 379;
var width = 4000;
var pixel = getPixelFromBuffer(buffer,test_x,test_y)

// Read directly from buffer
show_debug_message("Buffer values at " + string(test_x) + "," + string(test_y) + ":");
show_debug_message("B: " + string(pixel.b));
show_debug_message("G: " + string(pixel.g));
show_debug_message("R: " + string(pixel.r));
show_debug_message("A: " + string(pixel.a));

// Compare with surface
var surf_pixel = surface_getpixel_ext(surf, test_x, test_y);
show_debug_message("Surface values at same position:");
show_debug_message("R: " + string(color_get_red(surf_pixel)));
show_debug_message("G: " + string(color_get_green(surf_pixel)));
show_debug_message("B: " + string(color_get_blue(surf_pixel)));
show_debug_message("A: " + string(surf_pixel >> 24));
}

//print(getPixelFromBuffer(buffer, px+_fx, py+_fy))
if (getPixelFromBuffer(buffer, px+_fx, py+_fy).r == 255) {
	ship_master.contact = true
	//print("bang!")
}

if scanning{
	timer += delta_time/1000000
	if fmod_studio_event_instance_get_playback_state(eventLidarEngagedI) == FMOD_STUDIO_PLAYBACK_STATE.STOPPED {
		
		fmod_studio_event_instance_set_parameter_by_name(eventLidarEngagedI, "lidarEngaged", 1)
		fmod_studio_event_instance_start(eventLidarEngagedI)
	}

}
	
if timer >= timerTotal {
	fmod_studio_event_instance_set_parameter_by_name(eventLidarEngagedI, "lidarEngaged", 0)
	
	scanning = false
	oLeverAperture.engaged = false
	timer = 0
	hist++
	oLeverAperture.x -= 50
}


//print(array_length(hist))