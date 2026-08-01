shader_type spatial;

// Inverted-hull outline: this shader is meant to be used as a `next_pass` on the
// object's real material. It expands the mesh along its normals, culls the front
// faces, and draws a flat colour, so only the sliver sticking out past the
// original silhouette is visible.
render_mode unshaded, depth_draw_opaque;

uniform vec4 outline_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
// Thickness in metres at 1 unit from the camera, kept constant on screen.
uniform float outline_width : hint_range(0.0, 0.2, 0.001) = 0.02;
uniform bool active = true;

void vertex() {
  if (!active) {
    // Collapse the hull so nothing is rasterised when the outline is off.
    POSITION = vec4(0.0);
  }
else {
  // Grow along the normal in view space so the outline follows the silhouette
  // of the mesh instead of scaling it about its origin.
  vec3 view_normal = normalize(MODELVIEW_NORMAL_MATRIX * NORMAL);
  vec4 view_pos = MODELVIEW_MATRIX * vec4(VERTEX, 1.0);

  // Scale by view depth so the outline keeps a constant width on screen.
  float width = outline_width * -view_pos.z;
  view_pos.xyz += view_normal * width;

  POSITION = PROJECTION_MATRIX * view_pos;
	
}
}

void fragment() {
  ALBEDO = outline_color.rgb;
  ALPHA = outline_color.a;
}
