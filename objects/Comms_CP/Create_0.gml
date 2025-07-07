// Inherit the parent event
event_inherited();

interaction_shape = "rectangle"

x = 0
y = 0

function on_interaction_end() {

    room_goto(Comms)
}

function interaction_contains_point(x, y) {
    // Custom collision checking (only used if interaction_shape is "custom")
	print("Checking")
    return point_in_rectangle(x,y,0,0,300,300);
}