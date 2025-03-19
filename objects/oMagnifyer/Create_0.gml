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
	ShipMaster.shipStatus.map.magnifyerUp = !ShipMaster.shipStatus.map.magnifyerUp	
}

function interaction_contains_point(x, y) {
    // Custom collision checking (only used if interaction_shape is "custom")

	return mouseInBounds({x:x,y:y},100,100);

}
