uniform sampler2D spriteAtlas;

in vec2 v_uv;
in float v_opacity;

out vec4 frag_color;

void main() {
  vec4 straight_sample = texture(spriteAtlas, v_uv);
  float alpha = straight_sample.a * v_opacity;
  frag_color = vec4(straight_sample.rgb * alpha, alpha);
}
