function worldPos(screenPosX, screenPosY){
	
	var cam_x = camera_get_view_x(view_camera[0]);
	var cam_y = camera_get_view_y(view_camera[0]);
	var camW = camera_get_view_width(view_camera[0])
	var camH = camera_get_view_height(view_camera[0])
		
	var cam_angle = -ShipMaster.angle // Get camera rotation
    
    // Get camera center
    var cam_center_x = camW / 2;
    var cam_center_y = camH / 2;
	
	screenPosX -= cam_center_x;
    screenPosY -= cam_center_y;
	
	screenPosX *= 0.25;
    screenPosY *= 0.25;
	
	var angle_rad = degtorad(cam_angle);
	
	var rotated_x = screenPosX * cos(angle_rad) - screenPosY * sin(angle_rad);
    var rotated_y = screenPosX * sin(angle_rad) + screenPosY * cos(angle_rad);
    
    // Convert angle to radians
    
    
    // Calculate relative position before rotation
    var rel_x = rotated_x + cam_x;
    var rel_y = rotated_y + cam_y;
    
    // Translate to origin (camera center)
  

return {x:rel_x,y:rel_y}
}