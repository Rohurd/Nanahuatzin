shader_type canvas_item;

uniform float brightness = 1.0;
uniform float contrast = 1.0;
uniform float saturation = 1.0;

void fragment() {
	float p = 0.02;
	vec2 center = vec2(0.5, 0.5);
	vec2 diff = (center - SCREEN_UV)/0.5;
	vec2 dir = normalize(diff);
	vec2 uv = SCREEN_UV; 
	//+ dir*0.1*vec2(SCREEN_UV.x*(SCREEN_UV.x-1.0), SCREEN_UV.y*(SCREEN_UV.y-1.0)) ;
	vec3 c = textureLod(SCREEN_TEXTURE, uv, 0.0).rgb;
	COLOR = vec4(c.r, c.g, c.b, 1.0);
}