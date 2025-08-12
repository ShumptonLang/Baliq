depth = -600
//gpu_set_colorwriteenable(1,1,1,0)
//gpu_set_blendenable(true);

show_debug_overlay(1)

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

enum screenDimensions {
	x4K = 3840,
	x2K = 2880,
	y4K = 2160
}
 
 

function draw_surface_with_alpha(surf, x, y, alpha = 1) {
    gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha); // Premultiplied alpha blend
    draw_surface_ext(surf, x, y, 1, 1, 0, c_white, alpha);
    gpu_set_blendmode(bm_normal);
}

function drawToLayer(surface, drawLayer,roomDisplaySize, subLayer = "base", shader = -1){
	
	if surface_exists(surface){
		
		if struct_exists(layers,drawLayer) {

			if !struct_exists(layers[$ drawLayer],subLayer){
				layers[$ drawLayer][$ subLayer] = surface_create(surface_get_width(surface),surface_get_height(surface))
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
			draw_surface_with_alpha(surface,240,0)
		else
			draw_surface_with_alpha(surface,0,0)
		
		surface_reset_target()
		
		if shader != -1
			shader_reset()
		
		
	 }
 }
 
 function applyShaderToLayer(Layer,shader,subLayer = "base",shaderConfigFunction= function(){}){
	 var layerSurface = layers[$ Layer][$ subLayer]
	 var postShaderSurface = surface_create(surface_get_width(layerSurface),surface_get_height(layerSurface))
	 gpu_set_blendmode(bm_normal);
	 surface_set_target(postShaderSurface)
	 //New surfaces potentially contain old data. Need to clean them first.
	 draw_clear_alpha(c_black,0)
	 shader_set(shader)
	 shaderConfigFunction()
	 draw_surface(layerSurface,0,0)
	 shader_reset()
	 
	 surface_reset_target()
	 
	 surface_free(layerSurface)
	 layers[$ Layer][$ subLayer] = postShaderSurface
	 gpu_set_blendmode(bm_normal);
 }
 
 function surfaceClear(surface, alpha) {
	surface_set_target(surface)
	draw_clear_alpha(c_black,alpha)
	surface_reset_target()
 }
 
 function ensure_surface(surf, width, height) {
    if !surface_exists(surf) {
        return surface_create(width, height);
    }
    return surf;
}


function prepare_surface_for_drawing(surf, width, height, clear_alpha = 0) {
    if !surface_exists(surf) {
        surf = surface_create(width, height);
    }
    
    surface_set_target(surf);
    
    // CRITICAL: Set blend mode BEFORE clearing
    gpu_set_blendmode_ext(bm_one, bm_zero); // This overwrites everything
    draw_clear_alpha(c_black, clear_alpha);
    
    // Set proper blend mode for drawing with alpha
    gpu_set_blendmode_ext(bm_src_alpha, bm_inv_src_alpha);
    
    return surf;
}

function finish_surface_drawing() {
    gpu_set_blendmode(bm_normal);
    surface_reset_target();
}

