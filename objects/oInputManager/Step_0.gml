mouse_x_gui = device_mouse_x_to_gui(0)
mouse_y_gui = device_mouse_y_to_gui(0)
mouse_is_pressed = mouse_check_button(mb_left);
mouse_just_pressed = mouse_check_button_pressed(mb_left);
mouse_just_released = mouse_check_button_released(mb_left);

hover_interactable = noone

//print(ds_priority_size(interactables))

var highestPriority = -100000
var tempInteractable = noone

var temp_queue = ds_priority_create()
ds_priority_copy(temp_queue,interactables)

for (var i = 0; i < ds_priority_size(temp_queue); i++) {
    var obj = ds_priority_find_min(temp_queue);
    ds_priority_delete_min(temp_queue);
    
    // Check if object is under cursor and if it's interactive
    if (obj.is_interactive && point_in_interaction_area(obj, mouse_x_gui, mouse_y_gui)) {
        // Get the priority
		print(obj.interaction_priority)
        var priority = obj.interaction_priority;
        
        // Keep track of the highest priority interactable
        if (priority > highestPriority) {
            highestPriority = priority;
            tempInteractable = obj;
        }
    }
    
    // Re-add to priority queue
}
ds_priority_destroy(temp_queue)

hover_interactable = tempInteractable;

// Handle interaction state changes
if (mouse_just_pressed && hover_interactable != noone) {
    active_interactable = hover_interactable;
    with (active_interactable) {
        event_user(0); // On interaction start
    }
}

if (active_interactable != noone) {
    with (active_interactable) {
        event_user(1); // On interaction update
    }
    
    if (mouse_just_released) {
        with (active_interactable) {
            event_user(2); // On interaction end
        }
        active_interactable = noone;
    }
}