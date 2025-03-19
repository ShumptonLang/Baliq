/// @func State(name)
function State(_name) constructor {
    name = _name;
    
    // Override in specific states
    static enter = function() {};
    static execute = function() {};
    static stop = function() {};
}

/// @func StateMachine(owner)
function StateMachine(_owner) constructor {
    owner = _owner;
    currentState = undefined;
    previousState = undefined;
    states = {};
    
    static addState = function(_name, _state) {
        states[$ _name] = _state;
        return _state;
    }
    
    static getState = function() {
        return currentState
    }
    
    static changeState = function(_name) {
        var newState = states[$ _name];
        if (newState == undefined) {
            show_debug_message("WARNING: State '" + _name + "' doesn't exist!");
            return false;
        }
        
        if (currentState != undefined) {
            currentState.stop();
        }
        
        previousState = currentState;
        currentState = newState;
        currentState.enter();
        return true;
    }
    
    static update = function() {
        if (currentState != undefined) {
            currentState.execute();
        }
    }
}