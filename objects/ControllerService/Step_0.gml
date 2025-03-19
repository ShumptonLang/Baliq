for (var i = 0; i < array_length(timers); i++){
	var timer = array_shift(timers)
	if current_time >= timer.startTime + timer.duration {
		timer.callback()
	} else {
		array_push(timers,timer)
		timer.update(current_time-timer.startTime)
	}
}