sprite_index = spr_start
scalex = 800
scaley = 600




//Convert map into a surface
var surf = surface_create(4000,4000)//
surface_set_target(surf)
draw_sprite(sprite_index,0,0,0)
surface_reset_target()


global.currMapBuffer = buffer_create(4000 * 4000*4, buffer_fast, 1);
buffer_get_surface(global.currMapBuffer, surf, 0);


shadowSurf = surface_create(4000,4000)
surface_set_target(shadowSurf)
draw_set_color(c_black);
draw_rectangle(0, 0, room_width, room_height,false);
surface_reset_target()

screenSurf = surface_create(4000,4000)


instance_create_depth(0,0,5,oSonarMaster)
instance_create_depth(0,0,5,oLidarMaster)

instance_create_depth(1260,540,-5,oSonarButton)
instance_create_depth(438,184,-5,oLeverAperture)

instance_create_depth(0,0,-5,oNavRotation)
instance_create_depth(0,0,-5,oLeverForward)

drawables = [oSonarMaster,oLidarMaster,oSonarButton,oLeverAperture,oNavRotation,oLidarMaster]

// After creating and filling the buffer
