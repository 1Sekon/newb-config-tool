shader_type canvas_item;

uniform sampler2D tex : hint_screen_texture;

const float bluramount = 1.0;
const float stepSize = 4.004;
const float steps = 3.0;

const float minOffs = (float(steps-1.0)) / -2.0;
const float maxOffs = (float(steps-1.0)) / +2.0;

void vertex() {
}

void fragment() {
  float amount = bluramount * (1.0/vec2(textureSize(tex, 0)).y);
  vec4 blurred = vec4(0.0, 0.0, 0.0, 1.0);
  for (float offsY = minOffs; offsY <= maxOffs; ++offsY) {
    vec2 temp_tcoord = UV;
    temp_tcoord.y += offsY * amount * stepSize;
    blurred += texture(tex, temp_tcoord);
  }
  
  blurred /= float(steps * steps);
  
  vec4 diff = texture(tex, UV);
  diff.rgb += blurred.rgb;
  
  COLOR = diff;
}
