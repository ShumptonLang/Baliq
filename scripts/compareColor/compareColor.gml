/// @description Compares Color structs

/// @param {Struct} colorA The x coordinate
/// @param {struct} colorB The y coordinate
/// @returns {Bool} Is color the same
function compareColor(colorA,colorB){
	var same = (colorA.r == colorB.r) && (colorA.g == colorB.g) && (colorA.b == colorB.b)
    
    return same;
}