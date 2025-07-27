//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 u_center;
uniform float u_holeStrength;
uniform float u_holeRadius;
uniform bool u_disableHole;

void main()
{
	
	vec2 offset = v_vTexcoord - u_center;
	float dist = length(offset);
	float darkDist = dist;

	
	float darken = smoothstep(0.0,u_holeRadius,darkDist);
	darken = mix(1.0 - u_holeStrength, 1.0, darken);
	if (u_disableHole) {
		darken = 1.;	
	}
	
	//float hole = smoothstep(u_holeRadius*0.1,u_holeRadius*1.9,darkDist);
	
	
	vec4 finalColor = texture2D(gm_BaseTexture,v_vTexcoord) * v_vColour * darken;
	finalColor = vec4(step(0.5,finalColor.r));
	
    gl_FragColor = finalColor;
}
