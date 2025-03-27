print(ControllerService.shipStatus.balasts.rVolume)

draw_sprite(sBallastR,ControllerService.shipStatus.balasts.rStateMachine.currentState.name=="open"?irandom(1)+1:0,0,0)