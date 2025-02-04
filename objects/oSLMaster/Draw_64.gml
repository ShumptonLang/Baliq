if (!surface_exists(screenSurf)){
	screenSurf = surface_create(camera_get_view_width(view_camera[0]),camera_get_view_height(view_camera[0]))
	
}

//show_debug_message("Master: Starting clear")
	surface_set_target(screenSurf)
	draw_clear_alpha(c_black,0)
	surface_reset_target()
//show_debug_message("Master: Finished clear")
	
//show_debug_message("Master: Drawables")
for (var i = 0; i < array_length(drawables);i++){
	if drawables[i].isGui
		drawables[i].drawFunc()	
}


//draw_surface_ext(screenSurf,0,0,1,1,0,c_white,1)

var tex = surface_get_texture(screenSurf)
vertex_submit(vb, pr_trianglefan, tex);

//show_debug_message("Sonar: Starting draw")
if oSonarMaster.scanning || oLidarMaster.scanning {
	draw_sprite_ext(sSonarHud,1+irandom(1),0,0,1,1,0,c_white,1)
} else
	draw_sprite_ext(sSonarHud,0,0,0,1,1,0,c_white,1)


	

