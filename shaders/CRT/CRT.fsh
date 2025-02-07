
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float u_radControl;

vec3 chromaticAberration(vec2 uv, float strength) {
    float r = texture2D(gm_BaseTexture, uv + vec2(strength, 0.0)).r;
    float g = texture2D(gm_BaseTexture, uv).g;
    float b = texture2D(gm_BaseTexture, uv - vec2(strength, 0.0)).b;
    return vec3(r, g, b);
}

//float scanlineIntensity(vec2 uv, float time) {
//    float scanline = sin(uv.y * u_screenSize.y * 3.14159 * 2.0);
//   return mix(0.9, 1.0, abs(scanline)); // Adjust mix values for darker/brighter lines
//}

vec3 phosphorGlow(sampler2D tex, vec2 uv, float size, float intensity) {
    vec3 sum = vec3(0.);
	float uv_x = uv.x * size;
    float uv_y = uv.y * size;
        for (int n = 0; n < 9; ++n) {
			uv_y = (uv.y * size) + (size * float(n - 4));
            vec3 h_sum = vec3(0.);
            h_sum += texture2D(tex, vec2(uv_x - (4.0 * size),uv_y)).rgb;
            h_sum += texture2D(tex, vec2(uv_x - (3.0 * size),uv_y)).rgb;
            h_sum += texture2D(tex, vec2(uv_x - (2.0 * size),uv_y)).rgb;
            h_sum += texture2D(tex, vec2(uv_x - (1.0 * size),uv_y)).rgb;
            h_sum += texture2D(tex, vec2(uv_x ,uv_y)).rgb;
            h_sum += texture2D(tex, vec2(uv_x + (1.0 * size),uv_y)).rgb;
            h_sum += texture2D(tex, vec2(uv_x + (2.0 * size),uv_y)).rgb;
            h_sum += texture2D(tex, vec2(uv_x + (3.0 * size),uv_y)).rgb;
            h_sum += texture2D(tex, vec2(uv_x + (4.0 * size),uv_y)).rgb;
            sum += h_sum / 9.0;
        }

        return ((sum / 9.0) * intensity);
}

float vignette(vec2 uv) {
    uv *= 1.0 - uv.yx;
    float vig = uv.x * uv.y * 15.0;
    return pow(vig, 1.);
}

void main()
{
	vec2 uv = v_vTexcoord;
	
	vec3 color = chromaticAberration(uv,0.0009);
	vec3 glow = phosphorGlow(gm_BaseTexture,uv, 0.99985,25.);
	color += glow;
	glow = phosphorGlow(gm_BaseTexture,uv, 0.9985,5.);
	color += glow;
	glow = phosphorGlow(gm_BaseTexture,uv, 0.9975,2.8);
	color += glow;
	
	//color *= scanlineIntensity(uv, 1.1);
	
	
    gl_FragColor = vec4(color, 1.0);
}



