if isSampling {
	timer += delta_time/1000000	
}

if timer >= timerTotal {
	isSampling = false
	timer = 0
}