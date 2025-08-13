var scale = display_get_gui_height() / sprite_get_height(sPaleRoom)

displaySurface = RenderManager.prepare_surface_for_drawing(displaySurface,RenderManager.renderedImageX,RenderManager.renderedImageY)

draw_sprite_ext(sPaleRoom,0,0,0, 1, 1, 0, c_white,1)
draw_sprite_ext(sDesk,0,0,0, 1, 1, 0, c_white,1)
draw_sprite_ext(sSpeakers,0,0,0, 1, 1, 0, c_white,1)
RenderManager.finish_surface_drawing()


RenderManager.drawToLayer(displaySurface,"object", roomDisplayType.fullScreen)
RenderManager.applyShaderToLayer("object", paleShader, "base", paleShaderConf)