_start = [712,850]
x = _start[0]
y = _start[1]

prvMouseDeg = -1
prvHandleDeg = 180
mOccupiedOld = 0

isGui = true

bank_ref = fmod_studio_system_load_bank_file(fmod_path_bundle("Desktop//Master.bank"), FMOD_STUDIO_LOAD_BANK.NORMAL);
strings_bank_ref = fmod_studio_system_load_bank_file(fmod_path_bundle("Desktop//Master.strings.bank"), FMOD_STUDIO_LOAD_BANK.NORMAL);
SFXBankRef = fmod_studio_system_load_bank_file(fmod_path_bundle("Desktop//SFX.bank"), FMOD_STUDIO_LOAD_BANK.NORMAL);
eventRotWheel = fmod_studio_system_get_event("event:/RotationWheelTurned");
eventRotWheelInst = fmod_studio_event_description_create_instance(eventRotWheel);
eventGroan = fmod_studio_system_get_event("event:/hullGroans");
eventGroanInst = fmod_studio_event_description_create_instance(eventGroan);

function drawFunc(){
	//draw_sprite_ext(Sprite9,0, x,y,1,1,rot,c_white,1)
}