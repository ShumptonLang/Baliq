

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
		
		displaySurface = RenderManager.prepare_surface_for_drawing(displaySurface,screenDimensions.x2K,screenDimensions.y4K)
		draw_sprite_ext(CRTFrame,0,0,0,0.5,0.5,0,c_white,random_range(1,lerp(1,1,smoothstep(0,1,astigmaDifference))))
		RenderManager.finish_surface_drawing()
		
		RenderManager.drawToLayer(displaySurface,"background",displayType, "base")
		RenderManager.applyShaderToLayer("background", CRTExposure,"base" , exposureHandset)
		
		var astigmatism = ControllerService.shipStatus.comms.crtAstigma
		chromaCenter.x = astigmatism.x
		chromaCenter.y = astigmatism.y
		
		
		createCRTSurface(!isTransition and !isFinale)
		
		

		addCRTHole(isTransition)

		RenderManager.drawToLayer(displaySurface,"object", displayType, "crt")
		RenderManager.applyShaderToLayer("object", CRTBloom, "crt", crtBloomConf)
		RenderManager.applyShaderToLayer("object", CRTAberr, "crt", crtChromaticAberrationConf)
		
		print(ControllerService.shipStatus.comms.introSpriteStates.crt)
		
		
		
		
		


}

displaySurface = RenderManager.prepare_surface_for_drawing(displaySurface,screenDimensions.x2K,screenDimensions.y4K)
draw_sprite_ext(RadioLowLightBlank50,0,0,0,0.5,0.5,0,c_white,1)
draw_sprite_ext(Engine,0,0,0,0.5,0.5,0,c_white,ControllerService.shipStatus.comms.introSpriteStates.engine)

draw_sprite_ext(sBigDial,bigDialIDX,0,0,0.5,0.5,0,c_white,1)
draw_sprite_ext(sRadioLever,leverIdx,0,0,0.5,0.5,0,c_white,1)
draw_sprite_ext(sPowerDial,powerDialIdx,0,0,0.5,0.5,0,c_white,1)
draw_sprite_ext(sSmallSwitch,smallDialIDX,0,0,0.5,0.5,0,c_white,1)
RenderManager.finish_surface_drawing()

RenderManager.drawToLayer(displaySurface, "object", displayType, "machinery")
RenderManager.applyShaderToLayer("object",CRTExposure,"machinery",exposureTest)
if isTransition and ControllerService.shipStatus.comms.introSpriteStates.crt == 0
	RenderManager.applyShaderToLayer("object", MachineryBloom, "machinery", machineryBloomConf)
	
displaySurface = RenderManager.prepare_surface_for_drawing(displaySurface,screenDimensions.x2K,screenDimensions.y4K)
draw_sprite_ext(Speakers,0,0,0,0.5,0.5,0,c_white,ControllerService.shipStatus.comms.introSpriteStates.speakers)
RenderManager.finish_surface_drawing()

RenderManager.drawToLayer(displaySurface, "ui", displayType, "speaker")
RenderManager.applyShaderToLayer("ui",CRTExposure,"speaker",exposureSpeaker)




if ControllerService.shipStatus.comms.introSpriteStates.hideAll {
	displaySurface = RenderManager.prepare_surface_for_drawing(displaySurface,screenDimensions.x2K,screenDimensions.y4K)
	draw_rectangle_colour(0,0,surface_get_width(displaySurface),surface_get_height(displaySurface),c_black,c_black,c_black,c_black,0)	
	RenderManager.finish_surface_drawing()
	RenderManager.drawToLayer(displaySurface, "ui", displayType)
	
}
