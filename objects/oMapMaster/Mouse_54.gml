if ControllerService.shipStatus.map.activeTool != "pencil"{
	ControllerService.shipStatus.map.activeTool = "pencil"
	ControllerService.shipStatus.map.protractorState = 0
	ControllerService.shipStatus.map.protractorDrawing = false
}
else if ControllerService.shipStatus.map.magnifyerUp {
	ControllerService.shipStatus.map.magnifyerUp = false	
}
else {
	room_goto(Sonar)
}