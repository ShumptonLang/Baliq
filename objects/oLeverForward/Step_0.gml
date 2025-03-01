if !in_interaction {
	pctPulled = 0.9*pctPulled
	
	if pctPulled - (pctPulled % 0.50) < lastPctPulled -(lastPctPulled % 0.50) {
		
		audio_play_sound(click,1,0, 0.1)
			
	}
	lastPctPulled = pctPulled
	
}


x = _start[0] + pctPulled*_xdiff
y = _start[1] + pctPulled * _ydiff
	
	
