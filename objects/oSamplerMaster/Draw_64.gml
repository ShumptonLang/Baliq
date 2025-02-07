
if !oDigestMaster.isSampling{
var matLights = array_concat(aMatLights,bMatLights,cMatLights,dMatLights)

for (var i = 0; i < array_length(matLights); i++){
	draw_sprite_ext(sDigestLED, matLights[i][2],matLights[i][0],matLights[i][1],0.5,0.5,0,c_white,1)
}
}