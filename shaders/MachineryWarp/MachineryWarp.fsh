//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_ghostIntensity;
uniform float u_time;

float noise(vec2 p) {
    return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453);
}

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
	vec2 target = v_vTexcoord;
	
	float noiseCat = mod(noise(target),0.05);
	float dropSpeed = mod(noise(vec2(target.x+1.,target.y-1.)),0.03);
	float dropPosition = mod(u_time*dropSpeed,noiseCat);
	
	if (u_ghostIntensity > 0.) {
		target.y -= dropPosition;
		target.x += sin(target.y*4.+u_time * 0.4) * 0.0002*dropPosition/noiseCat;
	}
	
	
	
	
	//vec4 debugColor = vec4(target.x,target.y,0.,1.);
	vec4 debugColor = vec4(step(target.x,0.5),step(target.y,0.5),0.,1.);
	vec4 meltColor = v_vColour * texture2D( gm_BaseTexture, target );
	meltColor = apply_exposure_curve(meltColor,1.,1. + dropPosition/noiseCat );
	
	vec4 ogColor =v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	vec4 finColor = mix(ogColor,meltColor,u_ghostIntensity);

    gl_FragColor = finColor;

}
