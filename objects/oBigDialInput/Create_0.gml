// Inherit the parent event
event_inherited();



interaction_priority = 0;
interaction_shape = "circle"; // or "circle" or "custom"

interaction_radius = 25;

clickTimer = 0
secondsPerClick = 0.3

function on_interaction_start() {
	window_set_cursor(cr_none)	
}

function on_interaction_update() {
	clickTimer += delta_time
	
	if clickTimer/1000000 >= secondsPerClick {
		ControllerService.shipStatus.comms.bigDialState = (ControllerService.shipStatus.comms.bigDialState + 1) % 10
		audio_play_sound(click,1,0,-1,0,4)
		clickTimer = 0
	}
	
	if ControllerService.shipStatus.comms.startupState.currentState.name == "enable"{
		if oInputManager.mouse_x_gui < x 
			ControllerService.shipStatus.comms.crtAstigma.xv -= 0.0001
		if oInputManager.mouse_x_gui > x 
			ControllerService.shipStatus.comms.crtAstigma.xv += 0.0001
	}
	
}

function on_interaction_end() {
	window_set_cursor(cr_default)
	setMousePosition(x,y)
    ControllerService.shipStatus.comms.bigDialState = (ControllerService.shipStatus.comms.bigDialState + 1) % 10
	//ControllerService.shipStatus.comms.crtAstigma.x = abs(sin(ControllerService.shipStatus.comms.bigDialState/pi))
}

