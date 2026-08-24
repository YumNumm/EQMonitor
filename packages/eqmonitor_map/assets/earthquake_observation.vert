uniform ObservationFrame {
  vec4 camera_world;
  vec4 viewport_stroke;
}
observation_frame;

in vec2 corner;
in vec2 centerMercator;
in vec4 color;
in float radiusLogicalPixels;

out vec2 v_corner;
out vec4 v_color;
out float v_radius_logical_pixels;
out float v_stroke_logical_pixels;

void main() {
  vec2 camera = observation_frame.camera_world.xy;
  float world_size = observation_frame.camera_world.z;
  vec2 viewport = observation_frame.viewport_stroke.xy;

  vec2 world_delta = centerMercator - camera;
  world_delta.x -= round(world_delta.x);
  vec2 logical_delta = world_delta * world_size;
  vec2 center_ndc = vec2(
    logical_delta.x * 2.0 / viewport.x,
    -logical_delta.y * 2.0 / viewport.y
  );
  vec2 radius_ndc = radiusLogicalPixels * 2.0 / viewport;

  gl_Position = vec4(center_ndc + corner * radius_ndc, 0.0, 1.0);
  v_corner = corner;
  v_color = color;
  v_radius_logical_pixels = radiusLogicalPixels;
  v_stroke_logical_pixels = observation_frame.viewport_stroke.z;
}
