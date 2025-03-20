for (var i = 0; i < array_length(timers); i++){
	var timer = array_shift(timers)
	if current_time >= timer.startTime + timer.duration {
		timer.callback()
	} else {
		array_push(timers,timer)
		timer.update(current_time-timer.startTime)
	}
}

for (var i = 0; i < array_length(stateMachines); i++){
	var currMachine = stateMachines[i]
	currMachine.update()
}

print(shipStatus.map.stateMachine.currentState.name)
print(ControllerService.shipStatus.sonarLidar.rotationWheel,
	ControllerService.shipStatus.sonarLidar.forwardLever)