x = 500
y = 500

/// oInteractable - Create Event
is_interactive = true;
interaction_priority = 0;
interaction_shape = "custom"; // or "circle" or "custom"
interaction_width = sprite_width;
interaction_height = sprite_height;
interaction_radius = sprite_width / 2;

tlBound = {x: 133,y:209}
brBound = {x:822,y: 639}

// Register with input manager on creation
with (oInputManager) {
    register_interactable(other);
}

// Default interaction handlers - to be overridden by child objects
function on_interaction_start() {
    // Default behavior
}

function on_interaction_update() {
    // Default behavior for ongoing interaction
}

function on_interaction_end() {
    room_goto(MapTest)
}

function interaction_contains_point(x, y) {
    
    return mouseInRecBounds(tlBound,brBound);
}