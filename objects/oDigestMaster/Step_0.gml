waterVolume += abs((oPumpMaster.y - lastPumpPosition))*0.0001
lastPumpPosition = oPumpMaster.y
waterVolume = clamp(waterVolume,0,1)
updateStatus("waterVolume",waterVolume)


if isSampling {
	timer += delta_time/1000000	
}

if timer >= timerTotal {
	isSampling = false
	timer = 0
}

if chemicalCorrect {
	if waterVolume >=1 {
		if waterConditionsMet {
			updateStatus("running",true)
			audio_play_sound(engineStart,1,0)
		}
	}
	
}
chemicalCorrect = 0