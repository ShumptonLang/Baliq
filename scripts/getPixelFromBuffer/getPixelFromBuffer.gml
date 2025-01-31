/// @description Gets pixel color data from a buffer
/// @param {Id.Buffer} buffer The source buffer
/// @param {Real} _x The x coordinate
/// @param {Real} _y The y coordinate
/// @returns {Struct} Array of [r,g,b,a] values
function getPixelFromBuffer(buffer,_x,_y){
	var width = 4000; 
    var pixelOffset = (int64(_x) + width * int64(_y)) * 4;
	
	var colors = {
        r: buffer_peek(buffer, pixelOffset, buffer_u8),
        g: buffer_peek(buffer, pixelOffset + 1, buffer_u8),
        b: buffer_peek(buffer, pixelOffset + 2, buffer_u8),
        a: buffer_peek(buffer, pixelOffset + 3, buffer_u8)
    }
	
    
    return colors;
}