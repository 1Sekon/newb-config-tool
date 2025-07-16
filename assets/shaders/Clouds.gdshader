shader_type spatial;
render_mode unshaded;

#include "res://assets/newb/material/clouds.gdshaderinc"

global uniform sampler2D s_CloudTexture;

varying vec4 color;

void vertex() {
  vec4 a_color0 = textureLod(s_CloudTexture, UV+TIME*0.03, 0);
  bool isL2 = a_color0.g > 0.5 * a_color0.b;
  if (!(isL2))a_color0.a = 0.0;

  color = a_color0;
}

void fragment() {
  ALBEDO = color.rgb;
  ALPHA = color.a;
}
