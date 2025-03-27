
if not array_contains(roomStack,offlimitRooms[0]) {
	array_pop(roomStack)
	room_goto(array_last(roomStack))
}