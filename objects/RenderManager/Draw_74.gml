var parentRenderLayers = struct_get_names(layers)


for (var i = 0; i <= array_length(parentRenderLayers) - 1; i++) {
	var currentParentKey = parentRenderLayers[i]
	var currentParent = layers[$ currentParentKey]
	
	var renderLayers = struct_get_names(currentParent)
	
	for (var j = 0; j <= array_length(renderLayers) - 1; j++) {
		var renderLayerKey = renderLayers[j]
		var currentRenderLayerSurface = currentParent[$ renderLayerKey]
		
		surface_set_target(currentRenderLayerSurface)
		draw_clear_alpha(c_black,0)
		surface_reset_target()
	}
	
	
}
