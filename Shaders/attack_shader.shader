shader_type canvas_item;
render_mode blend_mix;

uniform float t;

void fragment() {
	vec2 x = UV;
	COLOR = vec4(0.1, 1.0, 0.1, 1.0);
	vec4 tex = texture(TEXTURE, UV);
	COLOR.a = tex.b * t;
	}
