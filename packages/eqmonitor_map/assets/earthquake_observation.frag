in vec2 v_corner;
in vec4 v_color;
in float v_radius_logical_pixels;
in float v_stroke_logical_pixels;

out vec4 frag_color;

void main() {
  float unit_distance = length(v_corner);
  if (unit_distance > 1.0) {
    discard;
  }

  float edge_distance = (1.0 - unit_distance) * v_radius_logical_pixels;
  float aa_width = max(fwidth(unit_distance) * v_radius_logical_pixels, 0.001);
  float coverage = smoothstep(0.0, aa_width, edge_distance);
  float stroke = 1.0 - smoothstep(
    v_stroke_logical_pixels - aa_width,
    v_stroke_logical_pixels + aa_width,
    edge_distance
  );
  vec4 straight_color = mix(v_color, vec4(1.0), stroke);
  float alpha = straight_color.a * coverage;
  frag_color = vec4(straight_color.rgb * alpha, alpha);
}
