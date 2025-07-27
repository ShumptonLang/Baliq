//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_exposure; 
uniform float u_gamma;

vec4 apply_exposure_curve(vec4 color_value, float exposure, float gamma) {
    vec4 normalized = color_value / 1.0;
    vec4 curved = vec4(0.);
	curved.r = pow(normalized.r, gamma);
	curved.g = pow(normalized.g, gamma);
	curved.b = pow(normalized.b, gamma);
	curved.a = pow(normalized.a, gamma);
    return curved * 1.0 * exposure;
}

void main()
{
	
	vec4 color = texture2D(gm_BaseTexture, v_vTexcoord);
	color = apply_exposure_curve(color, u_exposure, u_gamma);
    gl_FragColor = color*v_vColour;
}
