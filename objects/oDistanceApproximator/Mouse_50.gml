if(global.mouse_occupied == 0){
	if mouseInBounds(hand1,30) {
		global.mouse_occupied = "hand1"	
		lastHand = 1
	}
	if mouseInBounds(hand2,30) {
		global.mouse_occupied = "hand2"	
		lastHand = 2
	}
}