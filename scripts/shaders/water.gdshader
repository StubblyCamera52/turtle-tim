shader_type canvas_item;

uniform sampler2D noise: repeat_enable, filter_nearest;

varying vec2 world_pos;

void vertex() {
	world_pos = (MODEL_MATRIX * vec4(VERTEX, 0, 1.0)).xy;
}

const float noise_texture_size = 512.0;

void fragment() {
	vec2 sample = vec2(UV.x, 0);
	vec4 noise_color = texture(noise, sample);
	
	COLOR = noise_color;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
