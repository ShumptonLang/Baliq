

var flicker = abs(sin(current_time/10000))
var leverIdx = round(ControllerService.shipStatus.comms.leverState * 5)
var bigDialIDX = ControllerService.shipStatus.comms.bigDialState
var powerDialIdx = ControllerService.shipStatus.comms.PowerDialState
var smallDialIDX = ControllerService.shipStatus.comms.smallSwitchState

var brightnessMask = ControllerService.shipStatus.comms.totalPeriphAlpha
var isEnabled = ControllerService.shipStatus.comms.startupState.currentState.name == "enable"
var isFinale = ControllerService.shipStatus.comms.startupState.currentState.name == "finale"
var isTransition = ControllerService.shipStatus.comms.startupState.currentState.name == "transition"

if isEnabled or isTransition or isFinale  {
		draw_sprite_ext(CRTFrame,0,0,0,0.5,0.5,0,c_white,random_range(0.4,lerp(1,0.6,smoothstep(0,1,astigmaDifference))))
		var astigmatism = ControllerService.shipStatus.comms.crtAstigma
		
		if surface_exists(crtScreenSurface) {
			chromaCenter.x = astigmatism.x
			chromaCenter.y = astigmatism.y

			
			surface_set_target(crtScreenSurface)
			draw_clear_alpha(c_black,0)
			if ControllerService.shipStatus.comms.startupState.currentState.name != "transition" and !isFinale {
				draw_sprite_ext(sStatic,round((current_time)%8),0,0,1,1,0,c_white,random_range(0.7,lerp(1,0.8,smoothstep(0,1,astigmaDifference))))
			} else {
				switch (ControllerService.shipStatus.comms.introSpriteStates.crt){
					case 0:
						draw_sprite_ext(sStatic,round((current_time)%8),0,0,1,1,0,c_white,random_range(0.5,0.6))
						draw_sprite_ext(errorSprites[ControllerService.shipStatus.comms.introState],0,0,15,1,1,0,c_white,random_range(0.4,0.5))
					case 1:
						draw_sprite_ext(sStatic,round((current_time)%8),0,0,1,1,0,c_white,random_range(0.3,0.4))
						draw_sprite_ext(errorSprites[ControllerService.shipStatus.comms.introState],0,0,15,1,1,0,c_white,random_range(0.4,0.5))
				}
			}
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
			
			if ControllerService.shipStatus.comms.startupState.currentState.name != "transition"
				shader_set(CommCRTNormalizer)

			shader_set_uniform_f(shader_get_uniform(CommCRTNormalizer, "u_center"), chromaCenter.x, chromaCenter.y)
			shader_set_uniform_f(shader_get_uniform(CommCRTNormalizer, "u_holeStrength"), holeStr)
			shader_set_uniform_f(shader_get_uniform(CommCRTNormalizer, "u_holeRadius"), holeSize)
			
			vertex_submit(vb,pr_trianglefan,_tex)
			if ControllerService.shipStatus.comms.startupState.currentState.name != "transition"
				shader_reset()
		surface_reset_target()
		
		
		surface_set_target(crtTempSurface)
			draw_clear_alpha(c_black,0)
			shader_set(CRTBloom)
			shader_set_uniform_f(shader_get_uniform(CRTBloom, "u_strength"), rayLength)
			shader_set_uniform_f(shader_get_uniform(CRTBloom, "u_intensity"), rayIntensity)
			shader_set_uniform_f(shader_get_uniform(CRTBloom, "u_direction"), 792/1440, 390/1080)
			draw_surface(crtBleedSurface,0,0)
			shader_reset()
		surface_reset_target()
		
		shader_set(CRTAberr)
		shader_set_uniform_f(shader_get_uniform(CRTAberr, "u_strength"), chroma)
		shader_set_uniform_f(shader_get_uniform(CRTAberr, "u_direction"), chromaCenter.x, chromaCenter.y)
		draw_surface(crtTempSurface,0,0)
		
		shader_reset()
		
		gpu_set_blendmode(bm_normal);
		
		
		vertex_delete_buffer(vb);


}




draw_sprite_ext(RadioLowLightBlank50,0,0,0,0.5,0.5,0,c_white,0.5*brightnessMask)
draw_sprite_ext(Engine,0,0,0,0.5,0.5,0,c_white,ControllerService.shipStatus.comms.introSpriteStates.engine*0.25*brightnessMask)
draw_sprite_ext(Speakers,0,0,0,0.5,0.5,0,c_white,ControllerService.shipStatus.comms.introSpriteStates.speakers*((sin(current_time/1000)+4)/5 + random_range(0,0.01))*brightnessMask)
draw_sprite_ext(sBigDial,bigDialIDX,0,0,0.5,0.5,0,c_white,brightnessMask)
draw_sprite_ext(sRadioLever,leverIdx,0,0,0.5,0.5,0,c_white,brightnessMask)
draw_sprite_ext(sPowerDial,powerDialIdx,0,0,0.5,0.5,0,c_white,brightnessMask)
draw_sprite_ext(sSmallSwitch,smallDialIDX,0,0,0.5,0.5,0,c_white,brightnessMask)





