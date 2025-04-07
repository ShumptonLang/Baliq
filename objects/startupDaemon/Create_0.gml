
window_set_size(1440,1080)
game_set_speed(60,gamespeed_fps)

gpu_set_texfilter(true)
gpu_set_texrepeat(true)

#region Map Buffer Creation

//Convert map into a surface
var surf = surface_create(8000,8000)//
surface_set_target(surf)
draw_sprite(spr_start,0,0,0)
surface_reset_target()


global.currMapBuffer = buffer_create(8000 * 8000*4, buffer_fast, 1);
buffer_get_surface(global.currMapBuffer, surf, 0);



surf = surface_create(256,256)
surface_set_target(surf)
draw_sprite(funkyNoise,0,0,0)
surface_reset_target()


global.noiseBuffer = buffer_create(256 * 256*4, buffer_fast, 1);
buffer_get_surface(global.noiseBuffer, surf, 0);

global.lidarSurf = surface_create(1000,1000)
global.sonarSurf = surface_create(camera_get_view_width(view_camera[0]),camera_get_view_height(view_camera[0]))

global.mapSurf = surface_create(4000,4000)

global.distSurf = surface_create(128,256)

surface_set_target(global.distSurf)
draw_clear(c_black)
surface_reset_target()


#endregion


instance_create_depth(0,0,0,FMODManager)
instance_create_depth(0,0,-1000,oInputManager)
instance_create_depth(0,0,0,ControllerService)
instance_create_depth(0,0,0,AudioService)
instance_create_depth(0,0,0,ShipMaster)

room_goto(Cockpit)