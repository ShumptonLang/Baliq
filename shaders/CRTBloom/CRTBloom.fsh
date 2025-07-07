//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;


uniform int u_strength;
uniform vec2 u_direction;

void main()
{
	bool isAstigmatized = (!(u_direction.x == 0.) || !(u_direction.y == 0.));

	
	int stepSize = u_strength;
	vec2 blurAngle = normalize(-v_vTexcoord + u_direction)/1000.;	
	
	vec4 valueSample = vec4(0);
	vec4 finVal = vec4(0);
	bool killFlag = false;
	for (int i = 0; i < 50; i++){
		if (!killFlag){
			valueSample = texture2D(gm_BaseTexture, v_vTexcoord + vec2(float(i)*blurAngle.x,float(i)*blurAngle.y));
			if (valueSample.r > 0.1) {
				killFlag = true;
				finVal = vec4(1);
				finVal.a = 0.1/pow(length(vec2(float(i)*blurAngle.x,float(i)*blurAngle.y))*75.,2.);
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
