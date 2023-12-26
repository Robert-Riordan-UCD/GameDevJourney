shader_type canvas_item;

uniform vec2 target = vec2(0.5);
uniform float radius = 0.1;
uniform vec4 colour : source_color;

void fragment() {
	vec2 resolution = 1.0 / SCREEN_PIXEL_SIZE;
	vec2 current_pixel = SCREEN_UV * resolution;
	vec2 target_pixel = vec2(target.x, target.y) * resolution;
	
	float dist = distance(current_pixel, target_pixel);
	float rad = radius * length(resolution);
	
	COLOR = colour;
	COLOR.a = clamp(1.0 + dist - rad, 0.0, 0.8);
}
