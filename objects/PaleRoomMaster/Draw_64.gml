var scale = display_get_gui_height() / sprite_get_height(sPaleRoom)

displaySurface = RenderManager.prepare_surface_for_drawing(displaySurface,screenDimensions.x4K,screenDimensions.y4K)
//gpu_set_colorwriteenable(1,1,1,0)

	//gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
draw_sprite_ext(sPaleRoom,0,0,0, scale, scale, 0, c_white,1)
draw_sprite_ext(sDesk,0,0,0, scale, scale, 0, c_white,1)
draw_sprite_ext(sSpeakers,0,0,0, scale, scale, 0, c_white,1)
RenderManager.finish_surface_drawing()


//gpu_set_colorwriteenable(1,1,1,1)
//draw_surface_ext(displaySurface,0,0,1,1,0,c_white,1)

//draw_sprite_ext(sSpeakers,0,400,0, scale, scale, 0, c_white,1);
//draw_sprite_ext(sDesk,0,400,0, scale, scale, 0, c_white,1);
RenderManager.drawToLayer(displaySurface,"object", roomDisplayType.fullScreen)
RenderManager.applyShaderToLayer("object", paleShader, "base", paleShaderConf)