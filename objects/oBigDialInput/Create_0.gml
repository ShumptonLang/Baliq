// Inherit the parent event
event_inherited();



interaction_priority = 0;
interaction_shape = "circle"; // or "circle" or "custom"

interaction_radius = 25;



function on_interaction_update() {
	if oInputManager.mouse_x_gui < x
		ControllerService.shipStatus.comms.crtAstigma.x -= 0.0045
	if oInputManager.mouse_x_gui > x
		ControllerService.shipStatus.comms.crtAstigma.x += 0.0045
		
	ControllerService.shipStatus.comms.bigDialState = ControllerService.shipStatus.comms.crtAstigma.x*30 % 10
}

function on_interaction_end() {
	print("click!")
    ControllerService.shipStatus.comms.bigDialState = (ControllerService.shipStatus.comms.bigDialState + 1) % 10
	//ControllerService.shipStatus.comms.crtAstigma.x = abs(sin(ControllerService.shipStatus.comms.bigDialState/pi))
}

