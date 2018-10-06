shader_type canvas_item;
render_mode blend_mix;

uniform float t;

void fragment() {
	vec2 x = UV;
	COLOR = vec4(0.0, 1.0, 0.0, 0.0);
	vec4 tex = texture(TEXTURE, UV);
	if (tex.a > 0.0) {
		COLOR.y = 1.0;
		if (tex.b <  t+0.1 && tex.b > t-0.1){
			COLOR.a = (tex.b);
		}
	}
	}
