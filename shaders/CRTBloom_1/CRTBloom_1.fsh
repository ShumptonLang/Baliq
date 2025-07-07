//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;


uniform float u_strength;
uniform vec2 u_direction;

void main()
{
	bool isAstigmatized = (!(u_direction.x == 0.) || !(u_direction.y == 0.));

	
	float stepSize = u_strength;
	
	
	vec2 blurAngle = normalize(v_vTexcoord - u_direction) + v_vTexcoord;	
	vec4 blurTotal = vec4(0);
	float blurCount = 0.;
	
	int kernelSize = 3;
	
	if (!isAstigmatized){
		for (int x = -kernelSize; x <= kernelSize; x++){
			for (int y = -kernelSize; y <= kernelSize; y++){
				blurTotal += texture2D (gm_BaseTexture, v_vTexcoord + vec2(float(x),float(y))*stepSize);	
				blurCount+=stepSize;
			}
		}
	} else {
		for (int x = 0; x <= 2*kernelSize; x++){
			for (int y = 0; y <= 2*kernelSize; y++){
				blurTotal += texture2D (gm_BaseTexture, v_vTexcoord + vec2(float(x)*blurAngle.x,float(y)*blurAngle.y)*stepSize);	
				blurCount+=stepSize;
			}
		}
	}
	
	blurTotal /= blurCount;

	
	vec4 finalColor = texture2D(gm_BaseTexture,v_vTexcoord) * v_vColour;


	
    blurTotal.a *= blurAngle.x;
	gl_FragColor = blurTotal+finalColor;
}
