shader_type spatial;

// Plain textured surface. Pair it with outline.gdshader as a `next_pass` to get
// an outlined, textured object.
uniform sampler2D source_texture : source_color, filter_nearest;

void fragment() {
  vec4 tex = texture(source_texture, UV);
  ALBEDO = tex.rgb;
  ALPHA = tex.a;
}
