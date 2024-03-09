// out variables to be interpolated in the rasterizer and sent to each fragment shader:

varying  vec3  vN;	  // normal vector
varying  vec3  vL;	  // vector from point to light
varying  vec3  vE;	  // vector from point to eye
uniform float uTwist;
const float PI= 2.*3.14159265;
vec3
RotateZ( vec3 xyz, float radians )
{
	float c = cos(radians);
	float s = sin(radians);
	vec3 newxyz = xyz;
	newxyz.xy = vec2(
		dot( xyz.xy, vec2( c,-s) ),
		dot( xyz.xy, vec2( s, c) )
	);
	return newxyz;
}


uniform float uAmp; 
uniform float uFreq;
varying vec3 vColor;
varying float vX, vY,vZ;
varying float vLightIntensity;
const vec3 LIGHTPOS = vec3( 0., 0., 10. );
// light position
void main( ) {

	vec3 tnorm = normalize( gl_NormalMatrix * gl_Normal );
	vec3 ECposition = ( gl_ModelViewMatrix * gl_Vertex ).xyz;
	vLightIntensity = abs( dot( normalize(LIGHTPOS - ECposition), tnorm ) );
	vColor = gl_Color.rgb;
	vec3 MCposition = gl_Vertex.xyz; // model coordinates 
	float radians = 2. * PI * uTwist * MCposition.z;
	vec3 rotatedPosition = RotateZ(MCposition,radians);
	vX = rotatedPosition.x;
	vY = rotatedPosition.y;

	
	gl_Position = gl_ModelViewProjectionMatrix * vec4(vX, vY, rotatedPosition.z, 1.0);;
}

