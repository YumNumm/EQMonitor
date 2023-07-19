#include<flutter/runtime_effect.glsl>

uniform float time;
uniform vec2 resolution;

out vec4 FragColor;

void main(void){
   vec2 p=(FlutterFragCoord().xy*2.-resolution)/min(resolution.x,resolution.y);
   p+=vec2(cos(time/6.),sin(time/8.));
   // 画面外に持っていく
   p -= vec2(2.5,2.8);
   float l=(1.+sin(time)/8.)/(length(p)+.5);

   float r = (1.+cos(time)/8.)/(length(p + vec2(cos(time/6.),sin(time/8.)) )+.5) / 10.;
   float g = (1.+cos(time)/6.)/(length(p + vec2(cos(time/8.),sin(time/6.)) )+.5) / 10.;

   FragColor=vec4(r,g,l,1.);
}
