attribute vec2 in_Position;
attribute vec4 in_Colour;
attribute vec2 in_TextureCoord0;
attribute vec2 in_TextureCoord1;

varying vec4 v_Colour;
varying vec2 pos;
varying vec2 offset;
varying vec2 v_vTexcoord;

uniform float u_Time;

void main()
{
    // Calculate and pass UV coordinate
    pos = fract((in_Position/ in_TextureCoord0 + u_Time/10000.)/3.);
    v_vTexcoord = in_Position /in_TextureCoord0;
    // Try sampling with fixed coordinates first
    
    // Set offset and scale up significantly to make any movement visible
    offset = (in_TextureCoord1/255.) * 2. -1.;  // Removed the -1 to 1 mapping for testing
    vec2 position = in_Position.xy + offset;
	position.y += (pos.x * 2. - 1.)*3.;
    
    // Convert to clip space
    vec4 preFlip = vec4((position / in_TextureCoord0) * 2.0 - 1.0, 0.0, 1.0);
    preFlip.y = -preFlip.y;
    gl_Position = preFlip;
    
    // Pass noise directly as color for debugging
    v_Colour = in_Colour;
}