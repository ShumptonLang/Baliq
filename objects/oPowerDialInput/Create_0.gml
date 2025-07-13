// Inherit the parent event
event_inherited();




interaction_priority = 0;
interaction_shape = "circle"; // or "circle" or "custom"

interaction_radius = 25;




function on_interaction_end() {
	switch (ControllerService.shipStatus.comms.startupState.currentState.name) {
		case "off":
			print("moving to first enable!")
			ControllerService.shipStatus.comms.startupState.changeState("firstEnable")
			break
		case "enable":
			//ControllerService.shipStatus.comms.startupState.changeState("sleep")
			break
		case "sleep":
			ControllerService.shipStatus.comms.startupState.changeState("enable")
			break
	}
    ControllerService.shipStatus.comms.PowerDialState = (ControllerService.shipStatus.comms.PowerDialState + 1) % 2
}

