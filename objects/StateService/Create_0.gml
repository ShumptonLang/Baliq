persistent = true

globalStateMachines = {}

function initSystemStates() {
    // Create state machines for critical systems
    createStateMachine("sonarSystem");
    createStateMachine("navigationSystem");
    createStateMachine("digestiveSystem");
    createStateMachine("mapSystem");
    
    // Set initial states
    changeState("sonarSystem", "idle");
    changeState("navigationSystem", "standby");
    // etc...
}

// Create a state machine for a system
function createStateMachine(_systemId) {
    var machine = {};
    machine.currentState = "";
    machine.previousState = "";
    machine.stateData = {}; // Store state-specific data
    machine.stateStartTime = 0;
    machine.stateElapsedTime = 0;
    
    globalStateMachines[$ _systemId] = machine;
}

// Change a system's state
function changeState(_systemId, _newState, _stateData = {}) {
    var machine = globalStateMachines[$ _systemId];
    if (machine == undefined) {
        show_debug_message("WARNING: System '" + _systemId + "' doesn't exist!");
        return false;
    }
    
    machine.previousState = machine.currentState;
    machine.currentState = _newState;
    machine.stateData = _stateData;
    machine.stateStartTime = current_time;
    machine.stateElapsedTime = 0;
    
    // Broadcast state change event for any listening objects
    with (all) {
        event_user(15); // Using event 15 for state change notifications
    }
    
    return true;
}

// Get a system's current state
function getState(_systemId) {
    var machine = globalStateMachines[$ _systemId];
    if (machine == undefined) return "";
    return machine.currentState;
}

// Get state data for a system
function getStateData(_systemId) {
    var machine = globalStateMachines[$ _systemId];
    if (machine == undefined) return {};
    return machine.stateData;
}

// Initialize on creation
initSystemStates();