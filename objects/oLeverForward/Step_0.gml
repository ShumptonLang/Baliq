currPos.x = _xdiff*pctPulled+_start.x
currPos.y = _ydiff*pctPulled+_start.y

if !in_interaction {
	pctPulled = 0.9*pctPulled
	
	if pctPulled - (pctPulled % 0.50) < lastPctPulled -(lastPctPulled % 0.50) {
		
		audio_play_sound(click,1,0, 0.1)
			
	}
	lastPctPulled = pctPulled
	
}


	
	

