varying vec2 v_vTexcoord;
varying vec4 v_Colour;
varying vec2 pos;
varying vec2 offset;

uniform sampler2D u_NoiseTex;
uniform float u_Debug;
uniform float u_Time;


// Bubble data: x,y = position, z = size, w = birth time


void main()
{
	
    if (u_Debug > 0.5) {
        float deriv = dFdx(pos.x);
        // Show different debug outputs based on pos
        gl_FragColor = vec4(pos, 0.0, 1.0);
		//gl_FragColor = vec4(deriv,0.,0.,1.);// This will show us what coordinates we're getting
		//gl_FragColor = vec4(fract(pos * 4.0), 0.0, 1.0);
		//gl_FragColor = texture2D(u_NoiseTex, pos);
    } else {
        gl_FragColor = v_Colour;
    }
}