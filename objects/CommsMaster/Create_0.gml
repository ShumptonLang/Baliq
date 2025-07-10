instance_create_depth(0,0,0,LeverInput)
instance_create_depth(891,963,0,oBigDialInput)
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


chromaCenter = {x:0.5,y:0.5}

holeSizeAtEdge = 1.1
holeSizeAtCenter = 0.1

holeStrAtEdge = 0.35
holeStrAtCenter = 0.3

rayLengthAtCenter = 100
rayLengthAtEdge = 100

intensityAtEdge = 0.0000035
intensityAtCenter = 0.00001

chromaAtEdge = 0.05
chromaAtCenter = 0.1

astigmaDifference = 0

function escalateStage(){
	
	//Ramp up rays and intensity for a split second, Play a transcendental success sound and show a new image (White Circle) for a few seconds
	//Add the next Part of the scene
	
}




