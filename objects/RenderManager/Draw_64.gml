var parentRenderLayers = struct_get_names(layers)

//Blend set to add because otherwise alpha doesn't work. No clue why
//gpu_set_blendmode(bm_add)
for (var i = 0; i <= array_length(parentRenderLayers) - 1; i++) {
	var currentParentKey = parentRenderLayers[i]
	var currentParent = layers[$ currentParentKey]
	
	var renderLayers = struct_get_names(currentParent)

	for (var j = 0; j <= array_length(renderLayers) - 1; j++) {
		var renderLayerKey = renderLayers[j]
		var currentRenderLayerSurface = currentParent[$ renderLayerKey]

		draw_surface(currentRenderLayerSurface,0,0)

	}
	
	
}
gpu_set_blendmode(bm_normal);