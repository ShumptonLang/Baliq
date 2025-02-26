if global.mouse_occupied_changed and global.mouse_occupied == 0{
	if lastHand = 1 {
		window_mouse_set(hand1.x,hand1.y)	
	}
	
	if lastHand = 2 {
		window_mouse_set(hand2.x,hand2.y)	
	}
	
	lastHand = 0
}