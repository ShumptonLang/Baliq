interactables = ds_priority_create()
active_interactable = noone
hover_interactable = noone
previous_interactable = noone
mouse_was_pressed = false
mouse_is_pressed = false
mouse_just_pressed = false
mouse_just_released = false
positionDebug = false
wireframeDebug = false
wireframes = []
depth = -10000

mouse_x_gui = 0
mouse_y_gui = 0
//show_debug_overlay(1)

function point_in_interaction_area(obj, x, y) {
    // Check different collision shapes based on the object's interaction_shape property
    switch (obj.interaction_shape) {
        case "rectangle":
		if wireframeDebug
			array_push(wireframes, 
			[obj.x, 
                obj.y,
                obj.x + obj.interaction_width, 
                obj.y + obj.interaction_height]
				)
            return point_in_rectangle(x, y, 
                obj.x, 
                obj.y,
                obj.x + obj.interaction_width, 
                obj.y + obj.interaction_height);
            
        case "circle":
			array_push(wireframes,[obj.x, obj.y,obj.interaction_radius])
            return point_distance(x, y, obj.x, obj.y) < obj.interaction_radius;
            
        case "custom":
            // Call the object's custom collision check function
            with (obj) {
                return interaction_contains_point(x, y);
            }
    }
    return false;
}

function register_interactable(obj) {
    ds_priority_add(interactables, obj, obj.interaction_priority);
}

function unregister_interactable(obj) {
    // Find and remove the object from the priority queue
    var temp_queue = ds_priority_create();
    
    while (!ds_priority_empty(interactables)) {
        var current = ds_priority_find_min(interactables);
        var priority = ds_priority_find_priority(interactables, current);
        ds_priority_delete_min(interactables);
        
        if (current != obj) {
            ds_priority_add(temp_queue, current, priority);
        }
    }
    
    // Restore queue without the removed object
    while (!ds_priority_empty(temp_queue)) {
        var current = ds_priority_find_min(temp_queue);
        var priority = ds_priority_find_priority(temp_queue, current);
        ds_priority_add(interactables, current, priority);
        ds_priority_delete_min(temp_queue);
    }
    
    ds_priority_destroy(temp_queue);
}

function draw_wireframe(args) {
	if array_length(args) == 4 {
		draw_rectangle(args[0],args[1],args[2],args[3],1)	
	} else {
		draw_circle(args[0],args[1],args[2],1)	
	}
}
