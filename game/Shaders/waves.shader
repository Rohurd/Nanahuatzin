shader_type canvas_item;
render_mode blend_add;

uniform vec4 topcolor = vec4(0.14, 0.2, 0.5, 1.0);
uniform vec4 botcolor = vec4(0.0, 0.0, 0.4, 1.0);
uniform float cutoff = 0.8;
uniform float xspacing = 50;
uniform float yyspacing = 15;
uniform float yspacing = 50;
uniform float tspacing = 0.4;
uniform float tyspacing = 0.4;

void fragment() {
	vec4 p = FRAGCOORD;
	float x = p.x/xspacing + p.y/yspacing - tspacing * TIME + 0.3* sin(TIME + 0.01*p.x) * sin(0.1*p.y);
	float y = p.y/yyspacing;
	COLOR = vec4(0.0, 0.0, 1.0, 1.0);
	float dark = sin(x);
	if (dark > cutoff) {
		COLOR = topcolor;
	} else {
		COLOR = botcolor;
	}
	}
