varying vec2 v_vTexcoord;
varying vec4 v_Colour;
varying vec2 pos;
varying vec2 offset;

//uniform sampler2D u_NoiseTex;
uniform float u_Debug;

void main()
{
    if (u_Debug > 0.5) {
        // Try sampling at different coordinates
//        vec4 noise1 = texture2D(u_NoiseTex, pos);
//        vec4 noise2 = texture2D(u_NoiseTex, vec2(0.8, 0.5));  // Sample center
		
		vec2 uv = gl_FragCoord.xy;

//		vec4 noise_color = vec4(texture2D(u_NoiseTex, pos).rg, 0., 1.);

        
        // Show different debug outputs based on pos
        //gl_FragColor = vec4(pos, 0.0, 1.0);
		//gl_FragColor = noise1;// This will show us what coordinates we're getting
		//gl_FragColor = vec4(fract(pos * 4.0), 0.0, 1.0);
		gl_FragColor = vec4(offset.y,0.,0.,1.);
    } else {
        gl_FragColor = v_Colour;
    }
}