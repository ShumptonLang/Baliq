/// obj_StateManager - Step Event
// Update elapsed time for all state machines
var systems = variable_struct_get_names(globalStateMachines);
for (var i = 0; i < array_length(systems); i++) {
    var machine = globalStateMachines[$ systems[i]];
    machine.stateElapsedTime = (current_time - machine.stateStartTime) / 1000; // In seconds
}