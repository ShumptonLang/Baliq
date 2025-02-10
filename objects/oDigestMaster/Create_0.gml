master = ShipMaster
masteridx = ShipMaster.shipStatus.digestive

waterVolume = 0
waterConditionsMet = 0
chemicalCorrect = 0

dPower = 0

lastPumpPosition = 125

isSampling = false
instance_create_depth(0,0,-1,oSamplerMaster,{master:oDigestMaster, switchPositions:masteridx.compSwitchPositions})
instance_create_depth(0,0,-1,oIgnitionMaster,{master:oDigestMaster,switchStates:masteridx.ignitionSwitchStates, initState: masteridx.ignitionState})
instance_create_depth(700,125,-1,oPumpMaster,{_end:[700,375], initVolume: masteridx.waterVolume})


function updateStatus(statusid, status){
		switch(statusid){
			case "waterVolume":
			masteridx.waterVolume = status
			break;
			
			case "ignitionState":
				masteridx.ignitionState = status
			break;
			
			case "ignitionSwitchStates":
				masteridx.ignitionSwitchStates[status.pid] = status.state
			break;
			
			case "compSwitchPositions":
				masteridx.compSwitchPositions[status.pid] = status.state
			break;
			
			case "running":
				masteridx.running = status
			break;
		}
	
}