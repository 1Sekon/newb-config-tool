shader_type spatial;
render_mode unshaded, cull_disabled, blend_add, depth_draw_opaque, skip_vertex_transform;

#include "res://assets/newb/material/sunmoon.gdshaderinc"

global uniform sampler2D s_SunTexture : filter_nearest;
global uniform sampler2D s_MoonTexture : filter_nearest;

varying vec3 sPos;

void vertex() {
  vec3 pos = VERTEX;
  sPos = VERTEX;

  pos.xy *= SunMoonSize*11.4;
  if(ESunMoonAngle){
    float angle = SunMoonAngle*0.0174533;
    float sinA = sin(angle);
    float cosA = cos(angle);
    pos.xy = vec2(pos.x*cosA - pos.y*sinA, pos.x*sinA + pos.y*cosA);
  }

  VERTEX = (MODELVIEW_MATRIX*vec4(pos, 1.0)).xyz;
}

void fragment() {
  vec4 diffuse = texture(s_SunTexture, UV);
  if(sPos.z < 0.5)diffuse = texture(s_MoonTexture, UV);

  //diffuse.rgb *= SunMoondiffuse.rgb;
  diffuse.rgb *= 4.4*diffuse.rgb;
  float tr = 1.0 - 1.0;
  diffuse.a *= 1.0 - (1.0-SunMoonRain)*tr*tr;
  diffuse.rgb = colorCorrection(diffuse.rgb);

  ALBEDO = diffuse.rgb;
  ALPHA = diffuse.a;
}