buffer = global.currMapBuffer
shadowSurf = oSLMaster.shadowSurf

white = {
	r: 255,
	g: 255,
	b: 255,
	a: 255
}

hist = 0

bank_ref = fmod_studio_system_load_bank_file(fmod_path_bundle("Desktop//Master.bank"), FMOD_STUDIO_LOAD_BANK.NORMAL);
strings_bank_ref = fmod_studio_system_load_bank_file(fmod_path_bundle("Desktop//Master.strings.bank"), FMOD_STUDIO_LOAD_BANK.NORMAL);
SFXBankRef = fmod_studio_system_load_bank_file(fmod_path_bundle("Desktop//SFX.bank"), FMOD_STUDIO_LOAD_BANK.NORMAL);
eventLidarEngaged = fmod_studio_system_get_event("event:/lidarTimer");
eventLidarEngagedI = fmod_studio_event_description_create_instance(eventLidarEngaged);
//fmod_studio_event_instance_start(eventLidarEngagedI)



lastHistTotal = 0

isGui = true
drawFunc = function(){
	if surface_exists(oSLMaster.lidarSurf){
	surface_set_target(oSLMaster.lidarSurf)
	
	if lastHistTotal != (hist) || true{
		draw_clear_alpha($010101,0)
		lastHistTotal = (hist)
		var screenCoord = worldPos(0,0)
		//draw_sprite_general(spr_start,0,ShipMaster.posx-oSLMaster.view_width/2,ShipMaster.posy-oSLMaster.view_height/2,oSLMaster.view_width,oSLMaster.view_height,0,0,1,1,ShipMaster.angle,c_green,c_green,c_green,c_green,1)
		draw_sprite_general(spr_start,0,screenCoord.x-oSLMaster.view_width/2,screenCoord.y-oSLMaster.view_height/2,oSLMaster.view_width,oSLMaster.view_height,0,0,1,1,ShipMaster.angle,c_green,c_green,c_green,c_green,1)
		sprite_set_offset(spr_start,0,0)
		//draw_sprite_part_ext(dummyNoise,0,0,0,oSLMaster.view_width,oSLMaster.view_height,0,0,10,10,c_red,0.8)
	
	}
	surface_reset_target()
	}
}