
//uniform vec2 u_NoiseOffset;
//uniform sampler2D u_NoiseTex;


draw_sprite(sViewport,0,0,0)

if ControllerService.shipStatus.eyeCast.camREnabled{
	draw_sprite_ext(sViewport,1,0,0,1,1,0,c_white,0.1)

	var noiseTex = sprite_get_texture(noiseTexture,0)

	surface_set_target(global.distSurf)
	shader_set(CRTLidar)
	draw_clear(c_black)


	var noiseIdx = shader_get_sampler_index(CRTLidar, "u_NoiseTex")
	var noiseOffU = shader_get_uniform(CRTLidar, "u_NoiseOffset")

	texture_set_stage(noiseIdx,noiseTex)
	shader_set_uniform_f(noiseOffU,current_time/100000)

	var posCamLx = ShipMaster.posx - lengthdir_x(100,ShipMaster.angle)
	var posCamLy = ShipMaster.posy - lengthdir_y(100,ShipMaster.angle)

	draw_sprite_general(mapy,0,posCamLx -surface_get_width(global.distSurf)/2,posCamLy-surface_get_height(global.distSurf)/2,surface_get_width(global.distSurf),surface_get_height(global.distSurf),0,0,1,1,0,c_white,c_white,c_white,c_white,1)
	shader_reset()
	surface_reset_target()


	draw_surface_ext(global.distSurf,720+80,540,0.6,0.6,-90,c_white,1)
}