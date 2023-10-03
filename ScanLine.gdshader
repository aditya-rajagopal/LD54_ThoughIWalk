shader_type canvas_item;

uniform float _delay = 2.0f;

void fragment() {
	vec4 colour = vec4(vec3(1.0), 30.0f * clamp(0.005 - abs(SCREEN_UV.y + _delay - 1.0f - float(int(TIME * 160.0 / _delay) % 160)/160.0f * _delay), 0.0, 1.0));
	
	COLOR = colour;
}
