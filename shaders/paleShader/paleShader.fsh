varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float u_time;

float random(vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

float noise(vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);
    
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));
    
    vec2 u = f * f * (3.0 - 2.0 * f);
    
    return mix(a, b, u.x) + (c - a)* u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
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

void main() {
     vec2 uv = v_vTexcoord;
    
    // Subtle chromatic aberration (very slight color channel separation)
    float aberration = 0.0001 + sin(u_time * 0.07) * 0.0005*abs(uv.x-0.5)*2.;
    vec2 direction = normalize(uv - 0.5);
    
    float r = texture2D(gm_BaseTexture, uv + direction * aberration).r;
    float g = texture2D(gm_BaseTexture, uv).g;
    float b = texture2D(gm_BaseTexture, uv - direction * aberration).b;
    
    vec4 color = vec4(r, g, b, texture2D(gm_BaseTexture, uv).a);
    
    // Animated film grain
    float grain = (random(uv + u_time * 0.1) - 0.5) * 0.03;
	
	// Gentle contrast fluctuation (different timing than breathing)
    float contrast = 1. + sin(u_time * 0.007) * 0.04;
    
    // Subtle brightness breathing (very slow)
    float breathe = 1.12 + sin(u_time * 0.015) * 0.04;
	
	vec2 center = vec2(0.5);
    float vignette = 1. - (abs(distance(uv, center))*0.7);
	
	// Animated dark blobs
    vec2 blobUV = uv * 3.0 + u_time * 0.002; // Scale and slow movement
    float blob1 = noise(blobUV);
    float blob2 = noise(blobUV * 1.5 + vec2(100.0, 50.0)); // Different offset
    float blobs = (blob1 + blob2) * 0.5;
    
    // Create dark regions where blobs are high
    float darkening = smoothstep(0.7, 0.8, blobs) * 0.04; // Adjust these values
    
    // Apply effects
    color.rgb += grain;        // Grain
	
	color.rgb = (color.rgb - 0.5) * (contrast + darkening) + 0.5;
    color = apply_exposure_curve(color,1.,breathe+darkening);      // Breathing
	//color.rgb *= (1.0 - darkening); 
	color.rgb *= vignette;                           
    
    gl_FragColor = color * v_vColour;
}