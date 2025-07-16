shader_type canvas_item;

uniform sampler2D tex : hint_screen_texture;

const float bluramount = 0.25;
const float stepSize = 5.0;
const float steps = 4.0;

const float minOffs = (float(steps-1.0)) / -2.0;
const float maxOffs = (float(steps-1.0)) / 2.0;

void vertex() {
}

void fragment() {
  vec4 diff = texture(tex, UV);

  if(COLOR.a > 0.001){
    vec2 amount = bluramount * (1.0/vec2(textureSize(tex, 0)));
    vec4 blurred = diff;

    for (float offsX = minOffs; offsX <= maxOffs; ++offsX){
      for (float offsY = minOffs; offsY <= maxOffs; ++offsY){
        vec2 temp_tcoord = UV;
        temp_tcoord.x += offsX * amount.x * stepSize;
        temp_tcoord.y += offsY * amount.y * stepSize;
        blurred += texture(tex, temp_tcoord);
      }
    }

    blurred /= float(steps * steps);
    diff.rgb = mix(diff.rgb, blurred.rgb, COLOR.a);
    diff.rgb *= 1.0-COLOR.a*0.5;
  }

  COLOR = diff;
}
