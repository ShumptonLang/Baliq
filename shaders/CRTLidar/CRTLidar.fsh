
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float u_NoiseOffset;
uniform sampler2D u_NoiseTex;

float phosphorGlow(sampler2D tex, vec2 uv, float size, float intensity) {
    float sum = 0.0;
	float uv_x = uv.x * size;
    float uv_y = uv.y * size;
        for (int n = 0; n < 9; ++n) {
			uv_y = (uv.y * size) + (size * float(n - 4));
            float h_sum = 0.0;
            h_sum += texture2D(tex, vec2(uv_x - (4.0 * size),uv_y)).g;
            h_sum += texture2D(tex, vec2(uv_x - (3.0 * size),uv_y)).g;
            h_sum += texture2D(tex, vec2(uv_x - (2.0 * size),uv_y)).g;
            h_sum += texture2D(tex, vec2(uv_x - (1.0 * size),uv_y)).g;
            h_sum += texture2D(tex, vec2(uv.x ,uv.y)).g;
            h_sum += texture2D(tex, vec2(uv_x + (1.0 * size),uv_y)).g;
            h_sum += texture2D(tex, vec2(uv_x + (2.0 * size),uv_y)).g;
            h_sum += texture2D(tex, vec2(uv_x + (3.0 * size),uv_y)).g;
            h_sum += texture2D(tex, vec2(uv_x + (4.0 * size),uv_y)).g;
            sum += h_sum / 9.0;
        }

        return ((sum / 9.0) * intensity);
}

float rand(vec2 val) {
	return fract(sin(dot(val,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

void main()
{
	vec2 offset = vec2(u_NoiseOffset,u_NoiseOffset*0.98)/100000.;
	vec2 uv = v_vTexcoord;
	float noise = step(0.9, rand(uv+offset));
	
	
	//float noise = step(0.1,texture2D(u_NoiseTex, uv+nOff).r);
	
	vec3 aColor = texture2D(gm_BaseTexture, uv).rgb;
	float gray = 1. - aColor.r;
	gray = step(0.3,gray) * noise+ step(0.5,gray);
	//gray = 1. - gray;
	
	
	//color += glassMask;

	//color += phosphorGlow(uv, 0.003) * 1.;
	
	//color *= scanlineIntensity(uv, 1.1);
	
	gl_FragColor = vec4(gray,gray,gray,1.);
    //gl_FragColor = vec4(color,1.);
}



