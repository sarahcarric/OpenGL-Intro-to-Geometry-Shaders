// lighting uniform variables -- these can be set once and left alone:
uniform float   uKa, uKd, uKs;	 // coefficients of each type of lighting -- make sum to 1.0
uniform vec3    uColor;		 // object color
uniform vec3    uSpecularColor;	 // light color
uniform float   uShininess;	 // specular exponent

// square-equation uniform variables -- these should be set every time Display( ) is called:

float uA=5.0; 
float uP=0.25; 
float uTol=0.0;
varying float vX, vY;
varying vec3 vColor;
varying float vLightIntensity;
const vec3 WHITE = vec3( 1., 1., 1. );

void
main( )
{
	float r = sqrt( vX*vX + vY*vY ); 
	float rfrac = fract( uA*r );

	
	float f = fract( uA*vX );
	float t = smoothstep( 0.5-uP-uTol, 0.5-uP+uTol, f ) - smoothstep( 0.5+uP-uTol, 0.5+uP+uTol, f ); 
	vec3 rgb = vLightIntensity * mix( WHITE, vColor, t );
	gl_FragColor = vec4( rgb, 1. );

}

