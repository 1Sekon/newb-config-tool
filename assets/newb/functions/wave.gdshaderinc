#ifndef WAVE_H
#define WAVE_H

#include "res://assets/newb/uniformConfig.gdshaderinc"
#include "constants.gdshaderinc"
#include "noise.gdshaderinc"

void lanternWave(
  inout vec3 worldPos, vec3 cPos, vec3 bPos, vec2 bPosC, float texPosY, float rainFactor, vec2 uv1, float windStrength, highp float t
) {
  if(ELanternWave){
    bool y6875 = bPos.y==0.6875;
    bool y5625 = bPos.y==0.5625;

    bool isLantern = ( (y6875 || y5625) && bPosC.x==0.125 ) || ( (y5625 || bPos.y==0.125) && (bPosC.x==0.1875) );
    bool isChain = bPosC.x==0.0625 && y6875;

    // fix for non-hanging lanterns waving top part (works only if texPosY is correct)
    if (y5625 && (texPosY < 0.3 || (texPosY>0.55 && texPosY<0.69))) {
      isLantern = false;
    }

    if (uv1.x > 0.6 && (isChain || isLantern)) {
      // simple wave for angle
      float phase = dot(floor(cPos), vec3(0.3927));
      vec2 theta = vec2(t + phase, t*1.4 + phase);
      theta = sin(vec2(theta.x,theta.x+0.7)) + rainFactor*sin(vec2(theta.y,theta.y+0.7));
      theta *= LanternWave*windStrength;

      vec2 sinA = sin(theta);
      vec2 cosA = cos(theta);

      // apply XZ rotation
      vec3 pivotPos = vec3(0.5,1.0,0.5) - bPos;
      worldPos.x += dot(pivotPos.xy, vec2(1.0-cosA.x, -sinA.x));
      worldPos.y += dot(pivotPos, vec3(sinA.x*cosA.y, 1.0-cosA.x*cosA.y, sinA.y));
      worldPos.z += dot(pivotPos, vec3(sinA.x*sinA.y, -cosA.x*sinA.y, 1.0-cosA.y));
    }
  }
}

void nlWave(
  inout vec3 worldPos, inout vec3 light, float rainFactor, vec2 uv0, vec2 lit, vec3 bPos, vec4 color0, vec3 cPos, vec3 tiledCpos, highp float t, bool isColored, bool isTreeLeaves, bool isPlants, float camDist, sampler2D terrainTex
){

  if (camDist > WaveRange) {  // only wave nearby (better performance)
    return;
  }

  float waveFade = 2.0*max((camDist/WaveRange) - 0.5, 0.0);
  waveFade *= waveFade;

  // texture atlas has 64x32 textures (uv0.xy division)
  float texPosY = fract(uv0.y*vec2(textureSize(terrainTex, 0)).y/32.0);

  // x and z distance from block center
  vec2 bPosC = abs(bPos.xz-0.5);

  bool isTop = texPosY < 0.5;
  bool isFarmPlant = (bPos.y==0.9375) && (bPosC.x==0.25 ||  bPosC.y==0.25);
  bool shouldWave = ((isTreeLeaves || isPlants) && isColored) || (isFarmPlant && isTop);
  bool isRedStone = color0.r > 0.25 && color0.r > 3.0*color0.g  && color0.b == 0.0;

  float windStrength = lit.y*(noise1D(t*0.36) + rainFactor*0.4)*(1.0-waveFade);

  // darken farm plants bottom
  light *= isFarmPlant && !isTop ? 0.7 : 1.1;
  if (uv0.y<0.9306640625 && uv0.y>0.9130859375) { //<--- Short grass uv position
     //make grass bottom more dark depending how deep it is
    light *= mix(isTop ? 1.2 : 1.2 - 1.2*(bPos.y>0.0 ? 1.5-bPos.y : 0.5), 1.0, waveFade);
  }

  if (shouldWave && EPlantWave) {

    float wave = PlantWave*windStrength;

    if (isTreeLeaves) {
      wave *= 0.5;
    } else if (isPlants && !isTop && !isTreeLeaves) {
      // wave the bottom of grass in opposite direction
      // depending on how deep it is to make it look almost fixed
      //wave *= bPos.y > 0.0 ? bPos.y-1.0 : 0.0;
        wave *= mix(isTop ? 1.0 : 1.0 - 1.0*(bPos.y>0.0 ? 1.5-bPos.y : 1.0), 1.0, waveFade);
    }

    float phaseDiff = dot(cPos,vec3(NL_CONST_PI_QUART)) + fastRand(tiledCpos.xz + tiledCpos.y);
    wave *= 1.0 + mix(
      sin(t*WaveSpeed + phaseDiff),
      sin(t*WaveSpeed*1.5 + phaseDiff),
      rainFactor);

    worldPos.xyz -= vec3(wave, wave*wave*0.5, wave);
  }

  //lanternWave(worldPos, cPos, bPos, bPosC, texPosY, rainFactor, uv1, windStrength, t);
}

#endif