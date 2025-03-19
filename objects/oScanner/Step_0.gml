switch (state) {
	case "scanIn":
		if debugMapAnimated
			mapOffset = timer/timerScanIn * maxMapOffset
		if timer > timerScanIn {
			state = "wait1"
			
			timer = 0

		}
	break
	
	case "wait1":
		if timer > timerWait1 {
			state = "scanScan"
			audio_play_sound(sonarlaser,1,0,1,0,2)
			timer = 0

		}
	break
	
	
	case "scanScan":
		if timer > timerScanScan {
			state = "wait2"
			audio_stop_sound(sonarlaser)
			timer = 0
			isScanning = true
			
		}
	break
	
	case "wait2":
		
		if array_length(oMapMaster.navPath) {
			isErrored = false
			state = "navigating"
			if oMapMaster.state.scanningState == "off"
				oMapMaster.state.scanningState = "prune"
		} else {
			isErrored = true
			if timer > timerWait2 {
				state = "scanOut"
				timer = 0
				audio_play_sound(printer,1,0)
				isScanning = false
			}
		}
		
	break
		
	case "scanOut":
		isErrored = false
		if debugMapAnimated
			mapOffset = (1- timer/timerScanOut) * maxMapOffset
		if timer > timerScanOut {
			state = "off"
			timer = 0

		}
	break
		
}

if state != "off" {
	timer += delta_time / 1000000
	//print(timer,state)
}