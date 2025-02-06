


function genCompressedBuffer(buffer){
	// Assuming original_buffer is your existing buffer from the image

// First, scan the original buffer to find used regions

var height = sqrt(buffer_get_size(buffer) / 4)
var used_regions = array_create(0);

var xHead = -1; var yHead = -1;
var currM = [0,0,0,0]

for (var currY = 0; currY < height; currY++) {
	print(currY / height, "done", array_length(used_regions), "entries")
    for (var currX = 0; currX < height; currX++) {
        var pos = (currY * height + currX) * 4;
        buffer_seek(buffer, buffer_seek_start, pos);
        

		var texel = getPixelFromBuffer(buffer,currX,currY)
		var material = [texel.r,texel.g,texel.b,texel.a]
		
		var bail = false
		for (var i = 0; i < array_length(used_regions); i++){
				var region = used_regions[array_length(used_regions)-1-i]
				

				
				if !bail and (currX >= region.x and currX <= region.endX) and (currY >= region.y and currY <= region.endY){
					bail = true

				}
		}
		
		if bail
			continue
		

		xHead = currX
		yHead = currY
			currM = material
			while (array_equals(currM, material)){
				currX += 1
				currY += 1
				texel = getPixelFromBuffer(buffer,currX,currY)
				material = [texel.r,texel.g,texel.b,texel.a]
				
			}
			currX -= 1
			currY -= 1
			
			texel = getPixelFromBuffer(buffer,xHead,currY)
			material = [texel.r,texel.g,texel.b,texel.a]
			while(!array_equals(material,currM)){
				currY -= 1
			
				texel = getPixelFromBuffer(buffer,xHead,currY)
				material = [texel.r,texel.g,texel.b,texel.a]
			}
			texel = getPixelFromBuffer(buffer,currX,yHead)
			material = [texel.r,texel.g,texel.b,texel.a]
			while(!array_equals(material,currM)){
				currX -= 1
			
				texel = getPixelFromBuffer(buffer,xHead,currY)
				material = [texel.r,texel.g,texel.b,texel.a]
			}
			
			array_insert(used_regions,0, {
					x: xHead,
					y: yHead,
					endX: currX,
					endY: currY,
					data: currM
				});
			currX = xHead
			currY = yHead
			
    }
}

return used_regions
}
