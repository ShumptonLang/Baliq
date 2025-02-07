
if (global.mouse_occupied == self && !oDigestMaster.isSampling){
	oDigestMaster.isSampling = true
	
	var matLights = array_concat(aMatLights,bMatLights,cMatLights,dMatLights)
	var numCorrect = 0
	for (var i = 0; i < array_length(switches); i++){
		var diff = targetValues[i] - switches[i].pctPulled
		print(diff)
		
		if abs(diff) <= targetFuzz{
			matLights[2*i][2] = 1
			matLights[2*i + 1][2] = 1
			numCorrect++
			
		} else if sign(diff) == -1{
			matLights[2*i][2] = 1
			matLights[2*i + 1][2] = 0
		} else {
			matLights[2*i][2] = 0
			matLights[2*i + 1][2] = 1
		}
	}
	oDigestMaster.waterConditionsMet = (numCorrect == array_length(switches))
}
