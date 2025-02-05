 sprite_index = spr_start
scalex = 800
scaley = 600

view_width = camera_get_view_width(view_camera[0])
view_height =camera_get_view_height(view_camera[0])


//Convert map into a surface
var surf = surface_create(4000,4000)//
surface_set_target(surf)
draw_sprite(sprite_index,0,0,0)
surface_reset_target()


global.currMapBuffer = buffer_create(4000 * 4000*4, buffer_fast, 1);
buffer_get_surface(global.currMapBuffer, surf, 0);

surf = surface_create(256,256)//
surface_set_target(surf)
draw_sprite(funkyNoise,0,0,0)
surface_reset_target()


global.noiseBuffer = buffer_create(256 * 256*4, buffer_fast, 1);
buffer_get_surface(global.noiseBuffer, surf, 0);


//Create Aux Surfaces
shadowSurf = surface_create(4000,4000)
surface_set_target(shadowSurf)
draw_set_color(c_black);
draw_rectangle(0, 0, room_width, room_height,false);
surface_reset_target()

screenSurf = -1
lidarSurf = -1

//Create Room Objects
instance_create_depth(0,0,-3,oSonarMaster)
instance_create_depth(0,0,-3,oLidarMaster)
instance_create_depth(1260,540,-5,oSonarButton)
instance_create_depth(438,184,-5,oLeverAperture)
instance_create_depth(0,0,-5,oNavRotation)
instance_create_depth(0,0,-5,oLeverForward)

drawables = [oSonarMaster,oLidarMaster,oSonarButton,oLeverAperture,oNavRotation,oLidarMaster]

vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_color()
vertex_format_add_texcoord()
format = vertex_format_end();

var _uv_data = sprite_get_uvs(sSonarHud, 0);
//var _umin = _uv_data[0], _vmin = _uv_data[1], _umax = _uv_data[2], _vmax = _uv_data[3];
var scale = 2;
var _umin = 0.25, _vmin = 0.25, _umax = 0.75, _vmax = 0.75;

sonarBuffer = vertex_create_buffer();
lidarBuffer = vertex_create_buffer();

vertex_begin(sonarBuffer, format);
	
vertex_position_3d(sonarBuffer,   469,395, 0); vertex_color(sonarBuffer, c_white, 1); vertex_texcoord(sonarBuffer, (_umax+_umin)/2, (_vmax+_vmin)/2);
vertex_position_3d(sonarBuffer,   146,201, 0); vertex_color(sonarBuffer, c_white, 1); vertex_texcoord(sonarBuffer, _umin, _vmin);
vertex_position_3d(sonarBuffer, 495, 151, 0); vertex_color(sonarBuffer, c_white, 1); vertex_texcoord(sonarBuffer, (_umax+_umin)/2, _vmin);
vertex_position_3d(sonarBuffer,   863, 160, 0); vertex_color(sonarBuffer, c_white, 1); vertex_texcoord(sonarBuffer, _umax, _vmin);
vertex_position_3d(sonarBuffer, 898,376, 0); vertex_color(sonarBuffer, c_white, 1); vertex_texcoord(sonarBuffer, _umax, (_vmax+_vmin)/2);
vertex_position_3d(sonarBuffer, 920,627, 0); vertex_color(sonarBuffer, c_white, 1); vertex_texcoord(sonarBuffer, _umax, _vmax);
vertex_position_3d(sonarBuffer,   111,680, 0); vertex_color(sonarBuffer, c_white, 1); vertex_texcoord(sonarBuffer, _umin, _vmax);
vertex_position_3d(sonarBuffer, 120,422, 0); vertex_color(sonarBuffer, c_white, 1); vertex_texcoord(sonarBuffer, _umin, (_vmax+_vmin)/2);
vertex_position_3d(sonarBuffer,   146,201, 0); vertex_color(sonarBuffer, c_white, 1); vertex_texcoord(sonarBuffer, _umin, _vmin);

vertex_end(sonarBuffer); 
vertex_begin(lidarBuffer,format);

vertex_position_3d(lidarBuffer,   949,387, 0); vertex_color(lidarBuffer, c_white, 1); vertex_texcoord(lidarBuffer, _umin, _vmin);
vertex_position_3d(lidarBuffer,   1156,355, 0); vertex_color(lidarBuffer, c_white, 1); vertex_texcoord(lidarBuffer, _umax, _vmin);
vertex_position_3d(lidarBuffer, 1197, 556, 0); vertex_color(lidarBuffer, c_white, 1); vertex_texcoord(lidarBuffer, _umax, _vmax);
vertex_position_3d(lidarBuffer,   975, 583, 0); vertex_color(lidarBuffer, c_white, 1); vertex_texcoord(lidarBuffer, _umin, _vmax);
vertex_position_3d(lidarBuffer,   949,387, 0); vertex_color(lidarBuffer, c_white, 1); vertex_texcoord(lidarBuffer, _umax, _vmax);

vertex_end(lidarBuffer)