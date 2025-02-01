varying vec2 v_vTexcoord;
varying vec4 v_Colour;
varying vec2 pos;
varying vec2 offset;

uniform sampler2D u_NoiseTex;
uniform float u_Debug;

void main()
{
    vec2 uv = gl_FragCoord.xy;
    vec4 noise_color = texture2D(u_NoiseTex, pos);
	//noise_color = floor(noise_color);
	if (u_Debug > 0.5) {
		gl_FragColor = noise_color;
		//gl_FragColor = offset.xyxy;
	} else {
		gl_FragColor = v_Colour;
}}