waterVolume = 0
waterConditionsMet = 0
chemicalCorrect = 0

dPower = 0

lastPumpPosition = 125

isSampling = false
instance_create_depth(0,0,-1,oSamplerMaster)
instance_create_depth(0,0,-1,oIgnitionMaster)
instance_create_depth(700,125,-1,oPumpMaster,{_end:[700,375]})
