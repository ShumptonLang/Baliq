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

crtImage = sStatic

chromaCenter = {x:1,y:1}

errorSprites = [Error,ErrorT,ErrorC]

holeSize = 0
holeSizeAtEdge = 1.1
holeSizeAtCenter = 0.1

holeStr = 0
holeStrAtEdge = 0.2
holeStrAtCenter = 0.3

rayLength = 0
rayLengthAtCenter = 100
rayLengthAtEdge = 100

rayIntensity = 0
intensityAtEdge = 0.0000035
intensityAtCenter = [0.00001,0.0001,0.001]

chroma = 0
chromaAtEdge = 0.08
chromaAtCenter = [0.1,0.2,0.3]

astigmaDifference = 0

function escalateStage(){
	
	if ControllerService.shipStatus.comms.introState == 2
		ControllerService.shipStatus.comms.startupState.changeState("finale")
	else
		ControllerService.shipStatus.comms.startupState.changeState("transition")
	//Ramp up rays and intensity for a split second, Play a transcendental success sound and show a new image (White Circle) for a few seconds
	//Add the next Part of the scene
	
}




