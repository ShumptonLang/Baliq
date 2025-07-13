// Inherit the parent event
event_inherited();

interaction_shape = "custom"

x = 0
y = 0

function on_interaction_end() {

    room_goto(Comms)
}

function interaction_contains_point(x, y) {

    return point_in_rectangle(x,y,0,0,600,600);
}