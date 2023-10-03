shader_type canvas_item;

uniform float _delay = 2.0f;
uniform float _Curvature = 7.0f;

vec2 warp_edges(vec2 uv)
{
	// Warp edges
	vec2 updated_uv = uv * 2.0f - 1.0f;
	vec2 offset = updated_uv.yx / _Curvature;
	updated_uv *= 1.0f + offset * offset;
 	updated_uv = updated_uv * 0.5f + 0.5f;
	return updated_uv;
}

void fragment() {
	vec2 uv = SCREEN_UV; 
	vec4 colour = vec4(vec3(1.0), 30.0f * clamp(0.005 - abs(uv.y + _delay - 1.0f - float(int(TIME * 160.0 / _delay) % 160)/160.0f * _delay), 0.0, 1.0));
	
	COLOR = colour;
}
