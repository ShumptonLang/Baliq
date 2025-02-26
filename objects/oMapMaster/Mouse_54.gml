if state.activeTool == "protractor"{
	state.activeTool = "pencil"
	state.protractorState = 0
	state.protractorDrawing = false
}
else if state.magnifyerUp {
	state.magnifyerUp = false	
}
else
	room_goto(Sonar)