
uniform sampler2D u_screen;      // The screen texture
uniform sampler2D u_noiseText;   // Your noise texture
uniform float u_time;            // Time for animation
uniform vec2 u_resolution; 

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D u_NoiseTex;

void main()
{
    gl_FragColor = v_vColour * texture2D( u_NoiseTex, v_vTexcoord );
}
