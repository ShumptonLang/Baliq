
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform vec2 u_screenSize;
uniform sampler2D u_GlassTex;

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

void main()
{
	vec2 uv = v_vTexcoord;
	vec3 aColor = texture2D(gm_BaseTexture, uv).rgb;
	float intensity = (aColor.r +aColor.g+aColor.b);
	vec3 color = vec3(intensity,intensity,intensity) *3.;
	float glass = texture2D(u_GlassTex,uv).r;
	
	float colorMask = phosphorGlow(gm_BaseTexture, uv,1.02,1.);//+intensity;
	float glassMask = phosphorGlow(u_GlassTex,     uv,1.03,5.);
	
	float mask = colorMask * glassMask;
	//color += glassMask;

	//color += phosphorGlow(uv, 0.003) * 1.;
	
	//color *= scanlineIntensity(uv, 1.1);
	
	gl_FragColor = vec4(color,1.);
    //gl_FragColor = vec4(color,1.);
}



