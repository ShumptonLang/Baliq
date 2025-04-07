
var isOfflimits = roomLock

for(var i = 0; i < array_length(offlimitRooms); i++){
	if array_last(roomStack) == offlimitRooms[i] {
		isOfflimits = true
		
	}
		
}

if isOfflimits
	print("Last Room is off-limits! Preventing movement!!")

if not isOfflimits {
	array_pop(roomStack)
	room_goto(array_last(roomStack))
}