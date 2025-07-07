

var flicker = abs(sin(current_time/10000))
var leverIdx = round(ControllerService.shipStatus.comms.leverState * 5)
var bigDialIDX = ControllerService.shipStatus.comms.bigDialState
var powerDialIdx = ControllerService.shipStatus.comms.PowerDialState
var smallDialIDX = ControllerService.shipStatus.comms.smallSwitchState

draw_sprite_ext(CRTFrame,0,0,0,0.5,0.5,0,c_white,powerDialIdx*random_range(0.5,0.6))

if powerDialIdx {
		
		var astigmatism = ControllerService.shipStatus.comms.crtAstigma
		
		if surface_exists(crtScreenSurface) {
			chromaCenter.x = astigmatism.x
			chromaCenter.y = astigmatism.y
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
		gpu_set_blendmode(bm_add)
		surface_set_target(crtBleedSurface)
			draw_clear_alpha(c_black,0)
			var _tex = surface_get_texture(crtScreenSurface)
			shader_set(CommCRTNormalizer)

			shader_set_uniform_f(shader_get_uniform(CommCRTNormalizer, "u_center"), chromaCenter.x, chromaCenter.y)
			shader_set_uniform_f(shader_get_uniform(CommCRTNormalizer, "u_holeStrength"), 0.5)
			shader_set_uniform_f(shader_get_uniform(CommCRTNormalizer, "u_holeRadius"), 0.9)
			vertex_submit(vb,pr_trianglefan,_tex)
			shader_reset()
		surface_reset_target()
		
		
		surface_set_target(crtTempSurface)
			draw_clear_alpha(c_black,0)
			shader_set(CRTBloom)
			shader_set_uniform_f(shader_get_uniform(CRTBloom, "u_strength"), 1)
			shader_set_uniform_f(shader_get_uniform(CRTBloom, "u_direction"), chromaCenter.x, chromaCenter.y)
			draw_surface(crtBleedSurface,0,0)
			shader_reset()
		surface_reset_target()
		
		shader_set(CRTAberr)
		shader_set_uniform_f(shader_get_uniform(CRTAberr, "u_strength"), 0.2)
		shader_set_uniform_f(shader_get_uniform(CRTAberr, "u_direction"), chromaCenter.x, chromaCenter.y)
		draw_surface(crtTempSurface,0,0)
		shader_reset()
		
		gpu_set_blendmode(bm_normal);
		
		//print(oInputManager.mouse_x_gui / 1440, oInputManager.mouse_y_gui / 1080)
		vertex_delete_buffer(vb);


}




draw_sprite_ext(RadioLowLightBlank50,0,0,0,0.5,0.5,0,c_white,flicker)
draw_sprite_ext(sBigDial,bigDialIDX,0,0,0.5,0.5,0,c_white,flicker)
draw_sprite_ext(sRadioLever,leverIdx,0,0,0.5,0.5,0,c_white,flicker)
draw_sprite_ext(sPowerDial,powerDialIdx,0,0,0.5,0.5,0,c_white,flicker)
draw_sprite_ext(sSmallSwitch,smallDialIDX,0,0,0.5,0.5,0,c_white,flicker)





