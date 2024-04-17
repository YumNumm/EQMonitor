#include<flutter/runtime_effect.glsl>

precision highp float;
precision highp int;
uniform float time;
uniform vec2 resolution;

out vec4 FragColor;

float random (in vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

// Based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float noise (in vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    // Four corners in 2D of a tile
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;
}

#define OCTAVES 6
float fbm (in vec2 st) {
    // Initial values
    float value = 0.0;
    float amplitude = .5;
    float frequency = 0.;
    //
    // Loop of octaves
    for (int i = 0; i < OCTAVES; i++) {
        value += amplitude * noise(st);
        st *= 2.;
        amplitude *= .5;
    }
    return value;
}

vec3 baseColor(in vec2 pos) {
    pos += vec2(cos(time/3.0), sin(time/5.0));
    pos -= vec2(2.5);

    float r = length(pos) * 0.5;
    float g = length(pos) * 0.5;
    float b = length(pos) * 0.5;

    return vec3(r, g, b) / 60.;
}

void main(void){
    vec2 pos = (FlutterFragCoord().xy*2.-resolution)/min(resolution.x,resolution.y);
    vec2 st = FlutterFragCoord().xy/resolution.xy;
    st.x *= resolution.x/resolution.y;

    float f = fbm(st*3.0 + time/20) / 3.0;

    vec3 v = vec3(
        f,
        f,
        f * 2.
    );
    FragColor = vec4(v + baseColor(pos) ,1.0);

   // FragColor=vec4(r,g,l,1.);
}

