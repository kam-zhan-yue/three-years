shader_type sky;
uniform sampler2D sky_texture;

void sky() {
	vec2 n_out2p0 = UV2;

	vec4 n_out3p0;
	n_out3p0 = texture(tex, n_out2p0);
	COLOR.rgb = vec3(n_out3p0.xyz);
}
