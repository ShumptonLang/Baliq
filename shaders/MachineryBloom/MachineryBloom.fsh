//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;


uniform int u_strength;
uniform vec2 u_direction;

uniform float u_readability;
uniform float u_intensity;

void main()
{
	bool isAstigmatized = (!(u_direction.x == 0.) || !(u_direction.y == 0.));

	
	int stepSize = u_strength;
	vec2 blurAngle = normalize(-v_vTexcoord + u_direction)/1000.;	
	
	vec4 valueSample = vec4(0);
	vec4 finVal = vec4(0);
	bool killFlag = false;
	//Start-2
	//Dramatic-50
	//Ancestral-200
	for (int i = 0; i < 500; i++){
		if (!killFlag && i < u_strength){
			valueSample = texture2D(gm_BaseTexture, v_vTexcoord + vec2(float(i)*blurAngle.x,float(i)*blurAngle.y));
			float avg = (valueSample.r + valueSample.g + valueSample.b)/3.;
			if (valueSample.a > 0.25 && avg > 0.9) {
				killFlag = true;
				finVal = texture2D(gm_BaseTexture, v_vTexcoord);
				
				//start-0.1/0.0000035
				//dramatic-0.1/0.00001
				//Ancestral-0.5/0.0001
				finVal.a = u_intensity/pow(length(vec2(float(i)*blurAngle.x,float(i)*blurAngle.y))*1.,2.);
			}
		}
	}
	
	
	
	
	
	//vec4 blurTotal = vec4(0);
	//float blurCount = 0.;
	
	//int kernelSize = 3;
	
	//if (!isAstigmatized){
	//	for (int x = -kernelSize; x <= kernelSize; x++){
	//		for (int y = -kernelSize; y <= kernelSize; y++){
	//			blurTotal += texture2D (gm_BaseTexture, v_vTexcoord + vec2(float(x),float(y))*stepSize);	
	//			blurCount+=stepSize;
	//		}
	//	}
	//} else {
	//	for (int x = kernelSize; x <= 3*kernelSize; x++){
	//		for (int y = kernelSize; y <= 3*kernelSize; y++){
	//			blurTotal += texture2D (gm_BaseTexture, v_vTexcoord + vec2(float(x)*-blurAngle.x,float(y)*-blurAngle.y)*stepSize);	
	//			blurCount+=1.;
	//		}
	//	}
	//}
	
	//blurTotal /= blurCount;

	
	vec4 finalColor = texture2D(gm_BaseTexture,v_vTexcoord) * v_vColour;
	//finalColor.rgb += finVal.rgb;

	
    //blurTotal.a *= blurAngle.x;
	//gl_FragColor = blurTotal+finalColor;
	gl_FragColor = finVal;
}
