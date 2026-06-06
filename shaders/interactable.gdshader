shader_type spatial;

// This exposes the color picker to the Godot Inspeor
uniform vec4 normal_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 completed_color : source_color = vec4(0.0, 1.0, 0.0, 1.0);
uniform bool completed = false;

void fragment() {
  if (completed) {
    ALBEDO = completed_color.rgb;
  } else {
    ALBEDO = normal_color.rgb;
  }
}
