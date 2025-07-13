instance_create_depth(0,0,0,LeverInput)
instance_create_depth(891+240,963,0,oBigDialInput)
instance_create_depth(1070+240,891,0,oPowerDialInput)
instance_create_depth(865+240,906,0,oSmallSwitchInput)

crtScreenSurface = surface_create(320,240)

displaySurface = surface_create(1440,1080)
displayType = roomDisplayType.smallScreen

vertex_format_begin();
vertex_format_add_position();
vertex_format_add_colour();
vertex_format_add_texcoord();
format = vertex_format_end();

crtImage = sStatic

chromaCenter = {x:1,y:1}

errorSprites = [Error,ErrorT,ErrorC]

holeSize = 0
holeSizeAtEdge = 1.1
holeSizeAtCenter = 0.1

holeStr = 0
holeStrAtEdge = 0.2
holeStrAtCenter = 0.3

rayLength = 0
rayLengthAtCenter = 100
rayLengthAtEdge = 100

rayIntensity = 0
intensityAtEdge = 0.0000035
intensityAtCenter = [0.00001,0.0001,0.001]

chroma = 0
chromaAtEdge = 0.08
chromaAtCenter = [0.1,0.2,0.3]

astigmaDifference = 0

vb = vertex_create_buffer();
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

function escalateStage(){
	
	if ControllerService.shipStatus.comms.introState == 2
		ControllerService.shipStatus.comms.startupState.changeState("finale")
	else
		ControllerService.shipStatus.comms.startupState.changeState("transition")
	//Ramp up rays and intensity for a split second, Play a transcendental success sound and show a new image (White Circle) for a few seconds
	//Add the next Part of the scene
	
}
	
function createCRTSurface(useNoiseSprite){
	if surface_exists(crtScreenSurface) {
			
			surface_set_target(crtScreenSurface)
			draw_clear_alpha(c_black,0)
			if useNoiseSprite {
				draw_sprite_ext(sStatic,round((current_time)%8),0,0,1,1,0,c_white,random_range(0.7,lerp(1,0.8,smoothstep(0,1,astigmaDifference))))
			} else {
				switch (ControllerService.shipStatus.comms.introSpriteStates.crt){
					case 0:
						draw_sprite_ext(sStatic,round((current_time)%8),0,0,1,1,0,c_white,random_range(0.5,0.6))
						draw_sprite_ext(errorSprites[ControllerService.shipStatus.comms.introState],0,0,15,1,1,0,c_white,random_range(0.4,0.5))
					case 1:
						draw_sprite_ext(sStatic,round((current_time)%8),0,0,1,1,0,c_white,random_range(0.4,0.5))
						draw_sprite_ext(errorSprites[ControllerService.shipStatus.comms.introState],0,0,15,1,1,0,c_white,random_range(0.4,0.5))
				}
			}
			surface_reset_target()
		}
}
	
function addCRTHole(){
	surface_set_target(displaySurface)
		draw_clear_alpha(c_black,0)
		var _tex = surface_get_texture(crtScreenSurface)
			
		//if ControllerService.shipStatus.comms.startupState.currentState.name != "transition"
			shader_set(CommCRTNormalizer)

		shader_set_uniform_f(shader_get_uniform(CommCRTNormalizer, "u_center"), chromaCenter.x, chromaCenter.y)
		shader_set_uniform_f(shader_get_uniform(CommCRTNormalizer, "u_holeStrength"), holeStr)
		shader_set_uniform_f(shader_get_uniform(CommCRTNormalizer, "u_holeRadius"), holeSize)
			
		vertex_submit(vb,pr_trianglefan,_tex)
		//if ControllerService.shipStatus.comms.startupState.currentState.name != "transition"
			shader_reset()
	surface_reset_target()
}

function crtBloomConf(){
	shader_set_uniform_f(shader_get_uniform(CRTBloom, "u_strength"), rayLength)
	shader_set_uniform_f(shader_get_uniform(CRTBloom, "u_intensity"), rayIntensity)
	shader_set_uniform_f(shader_get_uniform(CRTBloom, "u_direction"), 800/1920, 367/1080)
}

function crtChromaticAberrationConf(){
	shader_set_uniform_f(shader_get_uniform(CRTAberr, "u_strength"), chroma)
	shader_set_uniform_f(shader_get_uniform(CRTAberr, "u_direction"), chromaCenter.x, chromaCenter.y)
}

function machineryBloomConf(){
	shader_set_uniform_f(shader_get_uniform(CRTBloom, "u_strength"), random_range(0,10))
	shader_set_uniform_f(shader_get_uniform(CRTBloom, "u_intensity"), random_range(0,0.000001))
	shader_set_uniform_f(shader_get_uniform(CRTBloom, "u_direction"), 800/1920, 367/1080)
}

function machineryChromaticAberrationConf(){
	shader_set_uniform_f(shader_get_uniform(CRTAberr, "u_strength"), chroma)
	shader_set_uniform_f(shader_get_uniform(CRTAberr, "u_direction"), chromaCenter.x, chromaCenter.y)
}




