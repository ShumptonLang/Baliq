
var flicker = abs(sin(current_time/10000))
var leverIdx = round(ControllerService.shipStatus.comms.leverState * 5)
var bigDialIDX = ControllerService.shipStatus.comms.bigDialState
var powerDialIdx = ControllerService.shipStatus.comms.PowerDialState
var smallDialIDX = ControllerService.shipStatus.comms.smallSwitchState

if powerDialIdx {
		
		var astigmatism = ControllerService.shipStatus.comms.crtAstigma
		
		if surface_exists(crtScreenSurface) {
			chromaCenter.x = oInputManager.mouse_x_gui / 1440
			chromaCenter.y = oInputManager.mouse_y_gui / 1080
			surface_set_target(crtScreenSurface)
			//shader_set(CommCRT)
			//shader_set_uniform_f(shader_get_uniform(CommCRT, "u_strength"), chromaStr)
			//shader_set_uniform_f(shader_get_uniform(CommCRT, "u_center"), chromaCenter.x, chromaCenter.y)
			draw_sprite_ext(sStatic,round((current_time)%8),0,0,1,1,0,c_white,1)
			//shader_reset()
			surface_reset_target()
		}
		
		
		
		//Draw Surface To Polygon
		var vb = vertex_create_buffer();


		vertex_begin(vb, format);
		
		vertex_position(vb,   820,   168); vertex_color(vb, c_white, 1); vertex_texcoord(vb, 0.5, 0.5);
		vertex_position(vb,   733,   60); vertex_color(vb, c_white, 1); vertex_texcoord(vb, 0, 0);
		vertex_position(vb,   862,   98); vertex_color(vb, c_white, 1); vertex_texcoord(vb, 0.5, 0);
		vertex_position(vb,   991,   155); vertex_color(vb, c_white, 1); vertex_texcoord(vb, 1, 0);
		vertex_position(vb,   963,   232); vertex_color(vb, c_white, 1); vertex_texcoord(vb, 1, 0.5);
		vertex_position(vb,   927,   322); vertex_color(vb, c_white, 1); vertex_texcoord(vb, 1, 1);
		vertex_position(vb,   649,   203); vertex_color(vb, c_white, 1); vertex_texcoord(vb, 0, 1);
		vertex_position(vb,   690,   121); vertex_color(vb, c_white, 1); vertex_texcoord(vb, 0, 0.5);
		vertex_position(vb,   733,   60); vertex_color(vb, c_white, 1); vertex_texcoord(vb, 0, 0);

		vertex_end(vb); 
		
		
		//Draw CRT to temp Screen Surface

		
		surface_set_target(crtBleedSurface)
		draw_clear_alpha(c_black,1)
		var _tex = surface_get_texture(crtScreenSurface)
		shader_set(CommCRTNormalizer)

		shader_set_uniform_f(shader_get_uniform(CRTBloom, "u_center"), chromaCenter.x, chromaCenter.y)
		shader_set_uniform_f(shader_get_uniform(CRTBloom, "u_holeStrength"), 0.2)
		shader_set_uniform_f(shader_get_uniform(CRTBloom, "u_holeRadius"), 0.9)
		vertex_submit(vb,pr_trianglefan,_tex)
		surface_reset_target()
		shader_reset()
		
		shader_set(CRTBloom)
		shader_set_uniform_f(shader_get_uniform(CRTBloom, "u_strength"), 1)
		shader_set_uniform_f(shader_get_uniform(CRTBloom, "u_direction"), oInputManager.mouse_x_gui / 1440, oInputManager.mouse_y_gui / 1080)
		draw_surface(crtBleedSurface,0,0)
		shader_reset()
		
		print(oInputManager.mouse_x_gui / 1440, oInputManager.mouse_y_gui / 1080)
		vertex_delete_buffer(vb);


}




draw_sprite_ext(RadioLowLightBlank50,0,0,0,0.5,0.5,0,c_white,flicker)
draw_sprite_ext(sBigDial,bigDialIDX,0,0,0.5,0.5,0,c_white,flicker)
draw_sprite_ext(sRadioLever,leverIdx,0,0,0.5,0.5,0,c_white,flicker)
draw_sprite_ext(sPowerDial,powerDialIdx,0,0,0.5,0.5,0,c_white,flicker)
draw_sprite_ext(sSmallSwitch,smallDialIDX,0,0,0.5,0.5,0,c_white,flicker)


//draw_sprite_ext(sCRTFrame,0,0,0,0.5,0.5,0,c_white,powerDialIdx)


