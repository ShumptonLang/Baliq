// Inherit the parent event
event_inherited();

is_interactive = true;
interaction_priority = 20;
interaction_shape = "custom"

magMapTL = {x:0,y:193}
magMapBR = {x:886,y:886}
magMapH = magMapBR.y - magMapTL.y
magMapW = magMapBR.x - magMapTL.x

function on_interaction_start() {
	oMapMaster.state.magnifyerUp = !oMapMaster.state.magnifyerUp	
}

function interaction_contains_point(x, y) {
    // Custom collision checking (only used if interaction_shape is "custom")
	if oMapMaster.state.magnifyerUp == false
		return mouseInBounds({x:60,y:450},100);
	else
		return mouseInBounds({x:1055,y:450},100)
}
