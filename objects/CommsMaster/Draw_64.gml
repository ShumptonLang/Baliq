

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
		
		draw_sprite_ext(CRTFrame,0,240,0,0.5,0.5,0,c_white,random_range(0.4,lerp(1,0.6,smoothstep(0,1,astigmaDifference))))
		var astigmatism = ControllerService.shipStatus.comms.crtAstigma
		chromaCenter.x = astigmatism.x
		chromaCenter.y = astigmatism.y
		
		
		createCRTSurface(!isTransition and !isFinale)
		
		
		
		addCRTHole()
		
		RenderManager.drawToLayer(displaySurface,"object", displayType, "crt")
		RenderManager.applyShaderToLayer("object", CRTBloom, "crt", crtBloomConf)
		RenderManager.applyShaderToLayer("object", CRTAberr, "crt", crtChromaticAberrationConf)
		
		print(ControllerService.shipStatus.comms.introSpriteStates.crt)
		
		
		
		
		


}

RenderManager.surfaceClear(displaySurface)

surface_set_target(displaySurface)
draw_set_alpha(1)
draw_sprite_ext(RadioLowLightBlank50,0,0,0,0.5,0.5,0,c_white,1)
draw_sprite_ext(Engine,0,0,0,0.5,0.5,0,c_white,ControllerService.shipStatus.comms.introSpriteStates.engine*1)
draw_sprite_ext(Speakers,0,0,0,0.5,0.5,0,c_white,ControllerService.shipStatus.comms.introSpriteStates.speakers*((sin(current_time/1000)+4)/5 + random_range(0,0.01))*1)
draw_sprite_ext(sBigDial,bigDialIDX,0,0,0.5,0.5,0,c_white,1)
draw_sprite_ext(sRadioLever,leverIdx,0,0,0.5,0.5,0,c_white,1)
draw_sprite_ext(sPowerDial,powerDialIdx,0,0,0.5,0.5,0,c_white,1)
draw_sprite_ext(sSmallSwitch,smallDialIDX,0,0,0.5,0.5,0,c_white,1)
surface_reset_target()

RenderManager.drawToLayer(displaySurface, "object", displayType, "machinery")
if isTransition
	RenderManager.applyShaderToLayer("object", CRTBloom, "machinery", machineryBloomConf())



