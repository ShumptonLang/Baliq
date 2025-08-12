if oInputManager.mouse_just_pressed
	clickCount += 1
	
if clickCount >= 3{
	room_goto(PaleRoom)
}