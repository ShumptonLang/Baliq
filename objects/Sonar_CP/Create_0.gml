// Inherit the parent event
event_inherited();
interaction_shape = "rectangle"

x = 800
y = 300

function on_interaction_end() {

    room_goto(Sonar)
}

function interaction_contains_point(x, y) {
    // Custom collision checking (only used if interaction_shape is "custom")
	print("Checking")
    return point_in_rectangle(x,y,500,500,1000,1000);
}