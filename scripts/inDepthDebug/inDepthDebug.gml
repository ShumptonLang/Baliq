// Create this function to inspect sprites
function debug_sprite_memory() {
    var total_mem = 0;
    for (var i = 0; i < 100; i++) {
        if (sprite_exists(i)) {
            var sprite_size = sprite_get_width(i) * sprite_get_height(i) * 4; // 4 bytes per pixel (RGBA)
            var subimages = sprite_get_number(i);
            var sprite_mem = sprite_size * subimages;
            
            show_debug_message("Sprite " + string(i) + 
                             " size: " + string(sprite_get_width(i)) + "x" + string(sprite_get_height(i)) +
                             " subimages: " + string(subimages) +
                             " memory: " + string(sprite_mem / 1024 / 1024) + " MB");
            
            total_mem += sprite_mem;
        }
    }
    show_debug_message("Total estimated sprite memory: " + string(total_mem / 1024 / 1024) + " MB");
}

// Add this to see texture page usage
function debug_texture_pages() {
    var tex_count = 0;
    var tex_mem = 0;
    
    for (var i = 0; i < 1000; i++) { // arbitrary upper limit
        if (true) {
            tex_count++;
            var tex_width = texture_get_width(i);
            var tex_height = texture_get_height(i);
            var page_size = tex_width * tex_height * 4;
            tex_mem += page_size;
            
            show_debug_message("Texture page " + string(i) + 
                             ": " + string(tex_width) + "x" + string(tex_height) +
                             " memory: " + string(page_size / 1024 / 1024) + " MB");
        }
    }
    show_debug_message("Total texture pages: " + string(tex_count));
    show_debug_message("Total texture memory: " + string(tex_mem / 1024 / 1024) + " MB");
}