var parentRenderLayers = struct_get_names(layers)


for (var i = 0; i <= array_length(parentRenderLayers) - 1; i++) {
	var currentParentKey = parentRenderLayers[i]
	var currentParent = layers[$ currentParentKey]
	
	var renderLayers = struct_get_names(currentParent)

	for (var j = 0; j <= array_length(renderLayers) - 1; j++) {
		var renderLayerKey = renderLayers[j]
		var currentRenderLayerSurface = currentParent[$ renderLayerKey]

		draw_surface_with_alpha(currentRenderLayerSurface,0,0,1,true)

	}
	
	
}
