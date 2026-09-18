uniform SpriteFrame {
  vec4 cameraWorld;
  vec4 viewportZoom;
  vec4 sizePolicy;
  vec4 opacityPolicy;
}
spriteFrame;

in vec2 corner;
in vec2 centerMercator;
in vec4 uvRect;
in vec2 logicalSize;
in float opacity;
in float priority;

out vec2 v_uv;
out float v_opacity;

void main() {
  vec2 world_delta = centerMercator - spriteFrame.cameraWorld.xy;
  world_delta.x -= round(world_delta.x);
  vec2 logical_delta = world_delta * spriteFrame.cameraWorld.z;
  vec2 viewport = spriteFrame.viewportZoom.xy;
  float zoom = spriteFrame.viewportZoom.z;
  float size_progress = clamp(
    (zoom - spriteFrame.sizePolicy.x) /
      (spriteFrame.sizePolicy.z - spriteFrame.sizePolicy.x),
    0.0,
    1.0
  );
  float size_scale = mix(
    spriteFrame.sizePolicy.y,
    spriteFrame.sizePolicy.w,
    size_progress
  );
  float policy_opacity = zoom < spriteFrame.opacityPolicy.x
    ? spriteFrame.opacityPolicy.y
    : spriteFrame.opacityPolicy.z;
  vec2 center_ndc = vec2(
    logical_delta.x * 2.0 / viewport.x,
    -logical_delta.y * 2.0 / viewport.y
  );
  vec2 corner_ndc = corner * logicalSize * size_scale / viewport;
  vec2 uv_mix = vec2(corner.x * 0.5 + 0.5, 0.5 - corner.y * 0.5);

  gl_Position = vec4(center_ndc + corner_ndc, 0.0, 1.0);
  v_uv = mix(uvRect.xy, uvRect.zw, uv_mix);
  v_opacity = opacity * policy_opacity * step(-1.0, priority);
}
