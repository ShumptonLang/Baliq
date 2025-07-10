astigmaDifference = sqrt( sqr(chromaCenter.x-0.5) + sqr(chromaCenter.y-0.5))/2
fmod_studio_event_instance_set_parameter_by_name(AudioService.commsStartupI,"astigmatismDifference",1-astigmaDifference)

if astigmaDifference > 0.5 {
	ControllerService.shipStatus.comms.crtAstigma.xv *= 0.98
	ControllerService.shipStatus.comms.crtAstigma.yv *= 0.98
} else if astigmaDifference > 0.25 {
	ControllerService.shipStatus.comms.crtAstigma.xv *= 0.96
	ControllerService.shipStatus.comms.crtAstigma.yv *= 0.96
} else {
	ControllerService.shipStatus.comms.crtAstigma.xv *= 0.92
	ControllerService.shipStatus.comms.crtAstigma.yv *= 0.92
}




ControllerService.shipStatus.comms.crtAstigma.x += ControllerService.shipStatus.comms.crtAstigma.xv
ControllerService.shipStatus.comms.crtAstigma.y += ControllerService.shipStatus.comms.crtAstigma.yv