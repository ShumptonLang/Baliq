attribute vec2 in_Position;                  // (x,y) (0,screen) Screen space
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord0;			// (width,height)
attribute vec2 in_TextureCoord1;			// (0,1) random position for noise offset

varying vec4 v_Colour;
varying vec2 pos;
varying vec2 offset;

uniform float u_Time;
uniform sampler2D u_NoiseTex;

void main()
{
	// Random offset + time (UV), unbounded, but wrapping is enabled
	pos = mod(in_TextureCoord1 + u_Time/10000.0,1.);
    
    // Sample noise (expecting and getting UV coordinates)
    vec4 noise = texture2D(u_NoiseTex, pos);
    
	//Convert noise from UV space to screen space.
    offset = noise.rg;
    
    // Apply offset in screen space
    vec2 position = vec2 (in_Position.x + offset.x, in_Position.y + offset.y);
    
    // Convert to clip space (-1 to 1) for final output
	vec4 preFlip = vec4((position / in_TextureCoord0) * 2.0 - 1.0, 0.0, 1.0);
	preFlip.y = -preFlip.y;
    gl_Position = preFlip;
    v_Colour = noise;
}