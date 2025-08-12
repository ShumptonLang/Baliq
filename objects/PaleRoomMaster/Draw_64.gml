var scale = display_get_gui_height() / sprite_get_height(sPaleRoom)

if !surface_exists(displaySurface)
	displaySurface = surface_create(window_get_width(),window_get_height())

RenderManager.surfaceClear(displaySurface, 1.0)
gpu_set_colorwriteenable(1,1,1,0)
surface_set_target(displaySurface)
	//gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
	draw_sprite_ext(sPaleRoom,0,0,0, scale, scale, 0, c_white,1)
	draw_sprite_ext(sDesk,0,0,0, scale, scale, 0, c_white,1)
	draw_sprite_ext(sSpeakers,0,0,0, scale, scale, 0, c_white,1)
	gpu_set_blendmode(bm_normal);

surface_reset_target()
gpu_set_colorwriteenable(1,1,1,1)
//draw_surface_ext(displaySurface,0,0,1,1,0,c_white,1)

//draw_sprite_ext(sSpeakers,0,400,0, scale, scale, 0, c_white,1);
//draw_sprite_ext(sDesk,0,400,0, scale, scale, 0, c_white,1);
RenderManager.drawToLayer(displaySurface,"object", roomDisplayType.fullScreen)
RenderManager.applyShaderToLayer("object", paleShader, "base", paleShaderConf)