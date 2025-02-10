if global.mouse_occupied == self and global.mouse_occupied_changed

	switch (state) {
	
		case "sleeping":
	
		for (var i = 0; i < array_length(buttonPos); i++) {
			var nuButton = instance_create_depth(buttonPos[i][0],buttonPos[i][1],-1,oIgnitionButton, {state:initStates[i], pid:i})
			array_insert(buttons,0,nuButton)
		}
	
		state = "idle"
		break;
	
		case "idle":
			var entry = []
			for (var i = 0; i < array_length(buttons); i++){
				array_insert(entry,0,buttons[i].state)	
			}
			print(entry)
			if array_equals(entry,correctCombo){
				state = "sleeping"
				for (var i = 0; i < array_length(buttons); i++){
					instance_destroy(buttons[i])
				}
				buttons = array_create(0)
				oDigestMaster.chemicalCorrect = true
			} else {
				state = "errored"	
			}
			break;
		
		case "errored":
			var sEntry = []
			for (var i = 0; i < array_length(buttons); i++){
				array_insert(sEntry,0,buttons[i].state)	
			}
			
			if array_equals(sEntry,correctCombo){
				state = "sleeping"
				for (var i = 0; i < array_length(buttons); i++){
					instance_destroy(buttons[i])
				}
				buttons = array_create(0)
				oDigestMaster.chemicalCorrect = true
			} else {
				state = "failure"	
			}
			break;
		
		
		
	
}
if state == "failure" {
	
			oDigestMaster.waterVolume *= 0.99
			
			if oDigestMaster.waterVolume <= 0.01
			{
				state = "sleeping"
				for (var i = 0; i < array_length(buttons); i++){
					instance_destroy(buttons[i])
				}
				buttons = array_create(0)
				initStates = correctCombo
			}
}



