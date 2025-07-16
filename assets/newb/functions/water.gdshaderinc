#ifndef WATER_H
#define WATER_H

#include "constants.gdshaderinc"
#include "detection.gdshaderinc"
#include "sky.gdshaderinc"
#include "clouds.gdshaderinc"
#include "noise.gdshaderinc"

// fresnel - Schlick's approximation
float calculateFresnel(float cosR, float r0) {
  float a = 1.0-cosR;
  float a2 = a*a;
  return r0 + (1.0-r0)*a2*a2*a;
}

vec4 nlWater(
  nl_skycolor skycol, nl_environment env, inout vec3 wPos, inout vec4 color, vec4 COLORv, vec3 viewDir, vec3 light, vec3 cPos, vec3 tiledCpos, 
  float fractCposY, vec3 FOG_COLOR, vec2 lit, highp float t, float camDist, vec3 torchColor
) {

  vec2 bump = vec2(disp(tiledCpos, WaterSpeed*t), disp(tiledCpos, WaterSpeed*(t+1.8))) - 0.5;
  vec3 nrm;
  if (fractCposY > 0.0) { // top plane
    nrm.xz = bump*WaterBump;
    nrm.y = -1.0;
    /*if (fractCposY>0.8 || fractCposY<0.9) { // flat plane
    } else { // slanted plane and highly slanted plane
    }*/
  } else { // reflection for side plane
    bump *= 0.5 + 0.5*sin(3.0*t*WaterSpeed + cPos.y*NL_CONST_PI_HALF);
    nrm.xz = normalize(viewDir.xz) + bump.y*(1.0-viewDir.xz*viewDir.xz)*WaterBump;
    nrm.y = bump.x*WaterBump;
  }
  nrm = normalize(nrm);

  float cosR = dot(nrm, viewDir);
  viewDir = viewDir - 2.0*cosR*nrm ; // reflect(viewDir, nrm)

  vec3 waterRefl = getSkyRefl(skycol, env, viewDir, FOG_COLOR, t);

  if (WaterReflection && (viewDir.y < 0.0)) {
    vec2 cloudPos = (120.0-wPos.y)*viewDir.xz/viewDir.y;
    float fade = clamp(2.0 - 0.005*length(cloudPos), 0.0, 1.0);

    if(EAurora){
      vec4 aurora = renderAurora(cloudPos.xyy, t, env.rainFactor, FOG_COLOR);
      waterRefl += aurora.rgb*aurora.a*fade;
    }

    if(CloudType == 1){
      vec4 clouds = renderCloudsSimple(skycol, cloudPos.xyy, t, env.rainFactor);
      waterRefl = mix(waterRefl, clouds.rgb, clouds.a*fade);
    }
  }

  // torch light reflection
  float tc = 0.5+0.5*sin(16.0*viewDir.x)*sin(16.0*viewDir.z);
  waterRefl += torchColor*TorchIntensity*lit.x*tc*tc;

  // mask sky reflection under shade
  if (!env.end) {
    waterRefl *= 0.05 + lit.y*1.14;
  }

  if(WaterMask){
    float mask = 0.05+0.05*sin(viewDir.x*12.0)*sin(viewDir.z*6.0);
    waterRefl *= smoothstep(mask-0.2,mask+0.13,viewDir.y*viewDir.y);
  }

  cosR = abs(cosR);
  float fresnel = calculateFresnel(cosR, 0.07);
  float opacity = 1.0-cosR;

  color.rgb *= 0.22*WaterTint*(1.0-0.8*fresnel);
  color.a = mix(COLORv.a*WaterAlpha, 1.0, opacity*opacity);

  if (WaterWave && (camDist < 14.0)) {
    wPos.y -= 0.5*(bump.x+0.5)*WaterBump;
  }

  return vec4(waterRefl, fresnel);
}

#endif
