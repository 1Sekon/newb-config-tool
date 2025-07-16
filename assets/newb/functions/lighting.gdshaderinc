#ifndef LIGHTING_H
#define LIGHTING_H

#include "detection.gdshaderinc"
#include "sky.gdshaderinc"
#include "constants.gdshaderinc"
#include "noise.gdshaderinc"
#include "clouds.gdshaderinc"

// sunlight tinting
vec3 sunLightTint(float dayFactor, float rain, vec3 FOG_COLOR) {

  float tintFactor = FOG_COLOR.g + 0.1*FOG_COLOR.r;
  float noon = clamp((tintFactor-0.37)/0.45,0.0,1.0);
  float morning = clamp((tintFactor-0.05)*3.125,0.0,1.0);

  vec3 clearTint = mix(
    mix(NightSunCol, MorningSunCol, morning),
    mix(MorningSunCol, NoonSunCol, noon),
    dayFactor
  );

  float r = 1.0-rain;
  r *= r;

  return mix(vec3(0.65,0.65,0.75), clearTint, r*r);
}

vec3 nlLighting(
  nl_skycolor skycol, nl_environment env, vec3 wPos, out vec3 torchColor, vec3 color0, vec3 FOG_COLOR,
  vec2 uv1, vec2 lit, bool isTree, float shade, highp float t
) {
  // all of these will be multiplied by tex uv1 in frag so functions should be divided by uv1 here

  vec3 light;

  if (env.nether || env.end) {
    // nether & end lighting
    light = env.end ? EndAmbient : NetherAmbient;

  } else {
    // overworld lighting
    
    float dayFactor = min(dot(FOG_COLOR.rgb, vec3(0.5,0.4,0.4))*(1.0 + 1.9*env.rainFactor), 1.0);
    float nightFactor = 1.0-dayFactor*dayFactor;
    float rainDim = min(FOG_COLOR.g, 0.25)*env.rainFactor;
    float lightIntensity = SunIntensity*(1.0 - rainDim)*(1.0 + NightBrightness*nightFactor);
    
    // min ambient in caves
    light = vec3((1.35+CaveBrightness)*(1.0-uv1.x)*(1.0-uv1.y));
    
    // sky ambient
    light += mix(skycol.horizon, skycol.zenith, 0.5+0.5)*((3.0-2.0)*(1.3 + (4.0*nightFactor) - rainDim));
    
    // shadow cast by top light
    float shadow = step(0.93, uv1.y);
    shadow = max(shadow, (1.0 - ShadowIntensity + (0.6*ShadowIntensity*nightFactor))*lit.y);
    shadow *= shade > 0.8 ? 1.0 : 0.8;
    
    // shadow cast by simple cloud
    //if(CloudShadow)shadow *= smoothstep(0.6, 0.1, cloudNoise2D(2.0*wPos.xz*Cloud1Scale, t, env.rainFactor));

    // direct light from top
    float dirLight = shadow*(1.0-uv1.x*nightFactor)*lightIntensity;
    light += dirLight*sunLightTint(dayFactor, env.rainFactor, FOG_COLOR);

    // extra indirect light
    light += vec3(0.3*lit.y*uv1.y*(1.2-shadow)*lightIntensity);
  }

  // darken at crevices
  light *= color0.g > 0.35 ? 1.0 : 0.8;

  // brighten tree leaves
  if (isTree) {
    light *= 1.25;
  }

  return light;
}

void nlUnderwaterLighting(inout vec3 light, inout vec3 pos, vec2 lit, vec2 uv1, vec3 tiledCpos, vec3 cPos, highp float t, vec3 horizonCol) {
  if (uv1.y < 0.9) {
    float caustics = disp(tiledCpos, WaterSpeed*t);
    caustics *= 3.0*caustics;
    light += UnderwaterBrightness + CausticIntensity*caustics*(0.15 + lit.y + lit.x*0.7);
  }
  light *= mix(normalize(horizonCol), vec3(0.6), lit.y*0.6);
  if(EUnderwaterWave)pos.xy += UnderwaterWave*min(0.05*pos.z,0.6)*sin(t*1.2 + dot(cPos,vec3(NL_CONST_PI_HALF)));
}
#endif
