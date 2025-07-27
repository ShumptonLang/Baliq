var isEnabled = ControllerService.shipStatus.comms.startupState.currentState.name == "enable"

astigmaDifference = sqrt(sqrt( sqr(chromaCenter.x-0.5) + sqr(chromaCenter.y-0.5)))
fmod_studio_event_instance_set_parameter_by_name(AudioService.commsStartupI,"astigmatismDifference",1-astigmaDifference)

if isEnabled
	ControllerService.shipStatus.comms.totalPeriphAlpha = sqrt(astigmaDifference)


var frict = lerp(0.8,0.9999,smoothstep(0,1,sqr(astigmaDifference)))
ControllerService.shipStatus.comms.crtAstigma.xv *= frict
ControllerService.shipStatus.comms.crtAstigma.yv *= frict

ControllerService.shipStatus.comms.crtAstigma.x += ControllerService.shipStatus.comms.crtAstigma.xv
ControllerService.shipStatus.comms.crtAstigma.y += ControllerService.shipStatus.comms.crtAstigma.yv

ControllerService.shipStatus.comms.crtAstigma.x = clamp(ControllerService.shipStatus.comms.crtAstigma.x,-0.1,1.1)
ControllerService.shipStatus.comms.crtAstigma.y = clamp(ControllerService.shipStatus.comms.crtAstigma.y,-0.1,1.1)


var currentStage = ControllerService.shipStatus.comms.introState

if ControllerService.shipStatus.comms.startupState.currentState.name != "transition" and ControllerService.shipStatus.comms.startupState.currentState.name != "finale" {
	holeStr = lerp(holeStrAtCenter,holeStrAtEdge,smoothstep(0,1,astigmaDifference))
	holeSize = lerp(holeSizeAtCenter,holeSizeAtEdge,smoothstep(0,1,astigmaDifference))
	rayLength = lerp(rayLengthAtCenter,rayLengthAtEdge,smoothstep(0,0.5,astigmaDifference))
	rayIntensity =  lerp(intensityAtCenter[currentStage],intensityAtEdge,smoothstep(0,0.5,astigmaDifference))
	chroma = lerp(chromaAtCenter[currentStage],chromaAtEdge,smoothstep(0,0.5,astigmaDifference))
}

if astigmaDifference < 0.224 and ControllerService.shipStatus.comms.startupState.currentState.name != "transition" and ControllerService.shipStatus.comms.startupState.currentState.name != "finale" {
	print(astigmaDifference, "triggering Transition",ControllerService.shipStatus.comms.startupState.currentState.name )
	escalateStage()	
}