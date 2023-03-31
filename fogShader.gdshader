//Fog Shader by Thiago Avidos "PbmnLuv"
//MIT License

shader_type spatial;
render_mode depth_draw_opaque, unshaded, shadows_disabled;

uniform sampler2D image;

varying vec3 world_pos;
uniform vec3 cameraPos;
uniform float fogMax;
uniform float fogMin;
uniform vec3 fogColor;

varying float distToCam;

void vertex() {
    world_pos = VERTEX;
	distToCam = distance(world_pos, cameraPos);

}
void fragment( )
{
	vec2 new_uv = UV;
	vec4 new_image = texture( image, new_uv );
            
    float alpha02 = 1.0f - (fogMax - distToCam) / (fogMax - fogMin);
            
    if (distToCam > fogMax) {
    	alpha02 = 1.0f;
    }
    if (distToCam < fogMin) {
    	alpha02 = 0.0f;
    }
            
    vec4 finalMix = mix(new_image, vec4(fogColor[0],fogColor[1],fogColor[2],1), alpha02);
	
	//In case you wanna intensify the effect use the line below again
	//finalMix = mix(finalMix, vec4(1,1,1,1), alpha02);
	
	ALBEDO = finalMix.rgb;
}
