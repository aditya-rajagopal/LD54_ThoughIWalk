shader_type canvas_item;

uniform float scan_line_multiplier = 4.0;
uniform float scan_line_impact = 0.5;

uniform float _VignetteWidth = 20;

uniform float _Curvature;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;

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
	vec2 uv = warp_edges(SCREEN_UV);
	vec4 colour  = texture(SCREEN_TEXTURE, uv);

	if (uv.x <= 0.0f || 1.0f <= uv.x || uv.y <= 0.0f || 1.0f <= uv.y)
        colour.rgb = vec3(0.0);
	
	uv = uv * 2.0f - 1.0f;
	vec2 screen_size = 4.0 / SCREEN_PIXEL_SIZE.xy;
	vec2 vignette = _VignetteWidth / screen_size ;
    vignette = smoothstep(vec2(0.0f), vignette, 1.0f - abs(uv));
    vignette = clamp(vignette, 0.0f, 1.0f);
	uv = uv * 0.5f + 0.5f;

	colour.g *= pow((sin(SCREEN_UV.y * screen_size.y * scan_line_multiplier) + 1.0f) * 0.15f + 1.0f, scan_line_impact);
    colour.rb *= pow((cos(SCREEN_UV.y * screen_size.y * scan_line_multiplier) + 1.0f) * 0.135f + 1.0f, scan_line_impact);
	colour.rgb = clamp(colour, 0.0f, 1.0f).rgb * vignette.x * vignette.y;
	
	COLOR = colour;
}
