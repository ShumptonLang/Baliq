 initialWindowDimensions = {x:0,y:0}
 initialWindowDimensions.x = window_get_width()
 initialWindowDimensions.y = window_get_height()
 
 layers = {
	background:	{
		base:surface_create(initialWindowDimensions.x,initialWindowDimensions.y)
		}, 
	object: {
		base:surface_create(initialWindowDimensions.x,initialWindowDimensions.y)
		},
	ui: {
		base:surface_create(initialWindowDimensions.x,initialWindowDimensions.y)
		}

 }
 
 enum roomDisplayType {
	smallScreen,
	fullScreen
	
}
 

function drawToLayer(surface, drawLayer,roomDisplaySize, subLayer = "base", shader = -1){
	
	if surface_exists(surface){
		
		if struct_exists(layers,drawLayer) {

			if ! struct_exists(layers[$ drawLayer],subLayer){
				struct_set(layers[$ drawLayer], subLayer, surface_create(initialWindowDimensions.x,initialWindowDimensions.y))
			}

			surface_set_target(layers[$ drawLayer][$ subLayer])
		}
		else {
			print("Referencing render layer that does not exist: ",drawLayer)
			return -1
		}
		
		if shader != -1
			shader_set(shader)
		
		if roomDisplaySize == roomDisplayType.smallScreen
			draw_surface(surface,480,0)
		else
			draw_surface(surface,0,0)
		
		surface_reset_target()
		
		if shader != -1
			shader_reset()
		
		
	 }
 }