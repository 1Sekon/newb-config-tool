shader_type canvas_item;

uniform sampler2D tex : hint_screen_texture;

const float bluramount = 0.4;
const float stepSize = 4.004;
const float steps = 5.0;

const float minOffs = (float(steps-1.0)) / -2.0;
const float maxOffs = (float(steps-1.0)) / +2.0;

void vertex() {
}

void fragment() {
  vec4 diff = texture(tex, UV);
  float amount = bluramount * (1.0/vec2(textureSize(tex, 0)).x);
  vec4 blurred = diff;
  
  for (float offsX = minOffs; offsX <= maxOffs; ++offsX) {   
    vec2 temp_tcoord = UV;
    temp_tcoord.x += offsX * amount * stepSize;
    blurred += texture(tex, temp_tcoord);
  }
  
  blurred /= float(steps * steps);
  diff.rgb = blurred.rgb;
  
  COLOR = diff;
}
