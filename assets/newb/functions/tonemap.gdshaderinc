#ifndef TONEMAP_H
#define TONEMAP_H

vec3 colorCorrection(vec3 col) {
  if(EExposure)col *= Exposure;

  // ref - https://64.github.io/tonemapping/
  if(TonemapType == 3){
    // extended reinhard tonemap
    const float whiteScale = 0.063;
    col = col*(1.0+col*whiteScale)/(1.0+col);
  } else if(TonemapType == 4){
    // aces tonemap
    const float a = 1.04;
    const float b = 0.03;
    const float c = 0.93;
    const float d = 0.56;
    const float e = 0.14;
    col *= 0.85;
    col = clamp((col*(a*col + b)) / (col*(c*col + d) + e), 0.0, 1.0);
  }else if(TonemapType == 2){
    // simple reinhard tonemap
    col = col/(1.0+col);
  }else if(TonemapType == 1){
    // exponential tonemap
    col = 1.0-exp(-col*0.8);
  }

  // gamma correction
  col = pow(col, vec3(1.0/Gamma));

  if(ESaturation)col = mix(vec3(dot(col,vec3(0.21, 0.71, 0.08))), col, Saturation);

  if(Tint)col *= mix(LTint, HTint, col);

  return col;
}

#endif
