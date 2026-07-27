shader_type spatial;
render_mode unshaded, fog_disabled;

uniform sampler2D depth_texture : hint_depth_texture, filter_linear_mipmap;
uniform sampler2D normal_texture : hint_normal_roughness_texture, filter_nearest;
uniform sampler2D screen_texture : hint_screen_texture;
uniform float pixel_size : hint_range(0.0, 100.0, 2.0) = 8.0;
uniform float line_highlight = 0.2;
uniform float line_shadow = 0.55;


void vertex() {
  POSITION = vec4(VERTEX.xy, 1.0, 1.0);
}

float get_linear_depth(vec2 uv, mat4 inv_proj_mat) {
  float depth = texture(depth_texture, uv).x;
  vec3 ndc = vec3(uv * 2.0 - 1.0, depth);
  vec4 view = inv_proj_mat * vec4(ndc, 1.0);
  view.xyz /= view.w;
  return -view.z;
}

vec3 get_normal(vec2 uv) {
  vec3 normal = texture(normal_texture, uv).rgb;
  normal = normal * 2.0 - 1.0;
  return normal;
}

float normal_edge_indicator(vec3 normal_edge_bias, vec3 normal, vec3 neighbour, float depth_difference) {
  float normal_difference = dot(normal - neighbour, normal_edge_bias);
  float normal_indicator = clamp(smoothstep(-.01, .01, normal_difference), 0.0, 1.0);
  float depth_indicator = clamp(sign(depth_difference * .25 + .0025), 0.0, 1.0);
  return (1.0 - dot(normal, neighbour)) * depth_indicator * normal_indicator;
}

void fragment() {
  vec2 texel_size = 1.0 / VIEWPORT_SIZE.xy;
  vec2 uv_offsets[4];
  uv_offsets[0] = vec2(-1.0, 0.0) * texel_size;
  uv_offsets[1] = vec2(1.0, 0.0) * texel_size;
  uv_offsets[2] = vec2(0.0, 1.0) * texel_size;
  uv_offsets[3] = vec2(0.0, -1.0) * texel_size;

  float depth_diff = 0.0;
  float inv_depth_diff = 0.5;
  float depth = get_linear_depth(SCREEN_UV, INV_PROJECTION_MATRIX);
  for (int i = 0; i < uv_offsets.length(); ++i) {
    float depth_offset = get_linear_depth(SCREEN_UV + uv_offsets[i], INV_PROJECTION_MATRIX);
    depth_diff += clamp(depth_offset - depth, 0.0, 1.0);
    inv_depth_diff += depth - depth_offset;
  }
  inv_depth_diff = clamp(inv_depth_diff, 0.0, 1.0);
  inv_depth_diff = clamp(smoothstep(0.9, 0.9, inv_depth_diff) * 10.0, 0.0, 1.0);
  depth_diff = smoothstep(0.25, 0.3, depth_diff);

  float normal_diff = 0.0;
  vec3 normal = get_normal(SCREEN_UV);
  vec3 normal_edge_bias = vec3(1.0);
  for (int i = 0; i < uv_offsets.length(); ++i) {
    vec3 normal_offset = get_normal(SCREEN_UV + uv_offsets[i]);
    normal_diff += normal_edge_indicator(normal_edge_bias, normal, normal_offset, depth_diff);
    normal_diff += 1.0 - dot(normal, normal_offset);
  }
  normal_diff = smoothstep(0.2, 0.2, normal_diff);
  normal_diff = clamp(normal_diff - inv_depth_diff, 0.0, 1.0);

  float inner_lines = clamp(normal_diff - depth_diff, 0.0, 1.0);

  float final = clamp(normal_diff + depth_diff, 0.0, 1.0);
  ALBEDO = vec3(final);
  ALBEDO = texture(screen_texture, SCREEN_UV).rgb;
  ALBEDO += inner_lines * line_highlight;
  ALBEDO -= ALBEDO * depth_diff * line_shadow;
}
