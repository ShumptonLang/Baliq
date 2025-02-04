
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform vec2 u_screenSize;

vec3 chromaticAberration(vec2 uv, float strength) {
    float r = texture2D(gm_BaseTexture, uv + vec2(strength, 0.0)).r;
    float g = texture2D(gm_BaseTexture, uv).g;
    float b = texture2D(gm_BaseTexture, uv - vec2(strength, 0.0)).b;
    return vec3(r, g, b);
}

float scanlineIntensity(vec2 uv, float time) {
    float scanline = sin(uv.y * u_screenSize.y * 3.14159 * 2.0);
    return mix(0.9, 1.0, abs(scanline)); // Adjust mix values for darker/brighter lines
}

vec3 phosphorGlow(vec2 uv, float radius) {
    vec3 color = texture2D(gm_BaseTexture, uv).rgb;
    color += texture2D(gm_BaseTexture, uv + vec2(radius, 0.0)).rgb;
    color += texture2D(gm_BaseTexture, uv - vec2(radius, 0.0)).rgb;
    color += texture2D(gm_BaseTexture, uv + vec2(0.0, radius)).rgb;
    color += texture2D(gm_BaseTexture, uv - vec2(0.0, radius)).rgb;
    return color / 5.0;
}

float vignette(vec2 uv) {
    uv *= 1.0 - uv.yx;
    float vig = uv.x * uv.y * 15.0;
    return pow(vig, 1.);
}

void main()
{
	vec2 uv = v_vTexcoord;
	
	vec3 color = chromaticAberration(uv,0.0004);
	color += phosphorGlow(uv, 0.003) * 1.;
	
	//color *= scanlineIntensity(uv, 1.1);
	
	
    gl_FragColor = vec4(color, 1.0);
}



