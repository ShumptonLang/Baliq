if ShipMaster.shipStatus.map.activeTool != "pencil"{
	ShipMaster.shipStatus.map.activeTool = "pencil"
	ShipMaster.shipStatus.map.protractorState = 0
	ShipMaster.shipStatus.map.protractorDrawing = false
}
else if ShipMaster.shipStatus.map.magnifyerUp {
	ShipMaster.shipStatus.map.magnifyerUp = false	
}
else {
	room_goto(Sonar)
}