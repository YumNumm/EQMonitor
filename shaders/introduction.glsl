#include <flutter/runtime_effect.glsl>

// use nice time-based shader from http://editor.thebookofshaders.com/


uniform float time;
uniform vec2 resolution;

out vec4 FragColor;

float makePoint(float x,float y,float fx,float fy,float sx,float sy,float t){
   float xx = x+sin(t*fx)*sx;
   float yy = y+cos(t*fy)*sy;
   return 3./sqrt(xx*xx+yy*yy);
}

void main( void ) {

   vec2 p=(FlutterFragCoord().xy/resolution.x) - vec2(0.5,0.5);

   float x=p.x;
   float y=p.y;

   float r=
      0.06 / makePoint(x,y,6.,2.9,0.3,0.3,time);

   float g=
      0.06 / makePoint(x,y,1.2,1.9,0.3,0.3,time);

   float b=
      0.4 / makePoint(x,y,1.2,1.2,0.4,0.3,time);

   vec3 d=vec3(r,g,b);

   FragColor = vec4(d,1.0);
}