instance_create_depth(0,0,0,LeverInput)
instance_create_depth(891,943,0,oBigDialInput)
instance_create_depth(1070,891,0,oPowerDialInput)
instance_create_depth(865,906,0,oSmallSwitchInput)

crtScreenSurface = surface_create(320,240)
crtBleedSurface = surface_create(1440,1080)
crtTempSurface = surface_create(1440,1080)

vertex_format_begin();
vertex_format_add_position();
vertex_format_add_colour();
vertex_format_add_texcoord();
format = vertex_format_end();

chromaStr = 0.1
chromaCenter = {x:0.5,y:0.5}






