/// @description Gets pixel color data from a buffer
/// @param {Id.Buffer} buffer The source buffer
/// @param {Real} _x The x coordinate
/// @param {Real} _y The y coordinate
/// @returns {Struct} Array of [r,g,b,a] values
function getPixelFromBuffer(buffer,_x,_y){
	
	var bufferSize = sqrt(buffer_get_size(buffer) / 4)
	
	_x = clamp(_x,0,bufferSize)
	_y = clamp(_y,0,bufferSize)
	

    var pixelOffset = (int64(_x) + bufferSize * int64(_y)) * 4;
	
	var colors = {
        r: buffer_peek(buffer, pixelOffset, buffer_u8),
        g: buffer_peek(buffer, pixelOffset + 1, buffer_u8),
        b: buffer_peek(buffer, pixelOffset + 2, buffer_u8),
        a: buffer_peek(buffer, pixelOffset + 3, buffer_u8)
    }
	
    
    return colors;
}