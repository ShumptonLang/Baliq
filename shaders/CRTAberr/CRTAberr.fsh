//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_strength;
uniform vec2 u_center;


void main()
{
	
	vec2 offset = v_vTexcoord - u_center;
	float dist = length(offset)/100.;
	
	vec2 chroma = normalize(offset)*dist*u_strength;
	
	float red = texture2D(gm_BaseTexture, v_vTexcoord + chroma).r;
    float blue = texture2D(gm_BaseTexture, v_vTexcoord - chroma).b;
	float green = (red+blue)/2.;
	
    gl_FragColor = vec4(red, green, blue, 1.0) * v_vColour;
}
