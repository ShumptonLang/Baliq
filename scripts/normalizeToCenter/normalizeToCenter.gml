function normalizeToCenter(screenSrc,surface){
	var tempLength = point_distance(oSLMaster.view_width / 2,oSLMaster.view_height/2,screenSrc.x,screenSrc.y)
				
				//Get Screen space clip
			var centeredPos = [screenSrc.x-oSLMaster.view_width/2,screenSrc.y-oSLMaster.view_height/2]
				

				 
				//Normalize  (-1,1)
			centeredPos[0] /= tempLength*(4/3) *3
			centeredPos[1] /= tempLength*(3/3)*3
				
				//centeredPos[0] /= tempLength*(4/3)
				//centeredPos[1] /= tempLength*(3/3)
				
				//Convert back to screen clip space (-w,-h)/2 (w,h)/2
			centeredPos[0] *= oSLMaster.view_width/2
			centeredPos[1] *= oSLMaster.view_height/2
				
				//Convert to screen space (0,0) (w,h)
			centeredPos[0] += oSLMaster.view_width/2
			centeredPos[1] += oSLMaster.view_height/2
			
			return {x : centeredPos[0], y : centeredPos[1]}
}