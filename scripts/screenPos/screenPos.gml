function screenPos(worldPosX, worldPosY,surface){
	
	
	var camW = surface_get_width(surface)
	var camH = surface_get_height(surface)
	var cam_x = ShipMaster.posx - camW/2;
	var cam_y = ShipMaster.posy - camH/2;
		
	var cam_angle = -ShipMaster.angle // Get camera rotation
    
    // Get camera center
    var cam_center_x = camW / 2;
    var cam_center_y = camH / 2;
    
    // Convert angle to radians
    var angle_rad = degtorad(cam_angle);
    
    // Calculate relative position before rotation
    var rel_x = worldPosX - cam_x;
    var rel_y = worldPosY - cam_y;
    
    // Translate to origin (camera center)
    rel_x -= cam_center_x;
    rel_y -= cam_center_y;
	
	var rotated_x = rel_x * cos(angle_rad) + rel_y * sin(angle_rad);
    var rotated_y = -rel_x * sin(angle_rad) + rel_y * cos(angle_rad);
	
	rotated_x += cam_center_x;
    rotated_y += cam_center_y;

return {x:rotated_x,y:rotated_y,normX:rotated_x/camW,normY:rotated_y/camH}
}