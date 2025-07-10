// Inherit the parent event
event_inherited();




interaction_priority = 0;
interaction_shape = "circle"; // or "circle" or "custom"

interaction_radius = 12;




function on_interaction_end() {
	ControllerService.shipStatus.comms.introState = (ControllerService.shipStatus.comms.introState + 1) % 3
    ControllerService.shipStatus.comms.smallSwitchState = (ControllerService.shipStatus.comms.smallSwitchState + 1) % 2
}

