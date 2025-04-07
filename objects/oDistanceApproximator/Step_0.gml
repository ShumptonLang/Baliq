hand1.frame = (hand1.frame + 1)%pinsPCol
hand2.frame = (hand2.frame + 1)%pinsPCol



hand1.scanA = hand1.a - hand1.frame + sweepAngle/2
hand2.scanA = hand2.a + hand2.frame - sweepAngle/2

grabDist(hand1)
grabDist(hand2)

if fmod_studio_event_instance_get_timeline_position(AudioService.ShipAmbienceInst)/1000 > 35
	ControllerService.roomLock = false