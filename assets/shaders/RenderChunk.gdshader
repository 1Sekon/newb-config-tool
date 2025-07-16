shader_type spatial;
render_mode unshaded, cull_disabled, depth_draw_always, skip_vertex_transform;

#include "res://assets/newb/material/renderchunk.gdshaderinc"

instance uniform bool Leaves = false;
instance uniform bool Season = false;

global uniform vec4 BiomeColor;
global uniform vec2 LightmapUV;
global uniform vec3 FogAndDistanceControl;
global uniform vec3 FogColor;
global uniform vec4 WaterColor;

global uniform sampler2D s_NoiseTexture;
global uniform sampler2D s_SeasonsTexture;
global uniform sampler2D s_LightMapTexture : filter_linear;
global uniform sampler2D s_AtlasTexture : filter_nearest_mipmap;
global uniform sampler2D s_BiomeColor : filter_nearest;

uniform sampler2D s_ScreenTexture : hint_screen_texture;
uniform sampler2D s_DepthTexture : hint_depth_texture;

varying vec4 color0;
varying vec4 color1;
varying vec4 vertColor;
varying vec3 cPos;
varying vec3 wPos;
varying vec3 bPos;
varying vec3 normal;
varying vec4 fog;
varying vec3 cmPos;

void vertex() {
  //Pretend "a_position" and "a_color0" are calculated in the game code, but it's actually not
  //Actually it's possible to do it using script but too lazy to do it...
  vec4 scolor = COLOR;
  if(COLOR.g > COLOR.b){
    scolor = textureLod(s_BiomeColor, (vec2(0.0, 1.0)/vec2(textureSize(s_BiomeColor, 0))), 0);
  }else if(COLOR.b > COLOR.r){
    scolor = WaterColor;
  }
  vec4 a_color0 = scolor;
  vec3 a_positon = (NODE_POSITION_WORLD*1.0-VERTEX);
  
  vec3 worldPos = (MODEL_MATRIX*vec4(VERTEX, 1.0)).xyz;
  vec3 camPos = CAMERA_POSITION_WORLD - worldPos;
  float camDis = length(camPos);
  vec3 viewDir = normalize(camPos);
  float relativeDist = camDis / FogAndDistanceControl.z;
  vec4 color = a_color0;
  
  cPos = a_positon;
  bPos = fract(cPos);
  vec3 tiledCpos = fract(cPos*0.0625);
  
  vec2 uv1 = LightmapUV;
  vec2 lit = uv1*uv1;
  
  bool isColored = color.r != color.g || color.r != color.b;
  float shade = isColored ? color.g*1.5 : color.g;
  
  bool isTree = false;
  bool isPlants = (COLOR.r < COLOR.g) && (COLOR.r != 0.0);
  if(isPlants && Leaves)isTree = true;
  
  if(Season && isPlants){
    color.w *= color.w;
    color = vec4(color.www, 1.0);
  }else{
    if(isColored)color.rgb *= color.rgb*1.2;
  }
  
  nl_environment env = nlDetectEnvironment(FogColor, FogAndDistanceControl);
  nl_skycolor skycol = nlSkyColors(env, FogColor);
  
  highp float t = TIME;
  
  vec3 torchColor; // modified by nl_lighting
  vec3 light = nlLighting(skycol, env, worldPos, torchColor, a_color0.rgb, FogColor, uv1, lit, isTree, shade, t);
  
  nlWave(worldPos, light, 0.0, UV, lit, bPos, a_color0, cPos, tiledCpos, t, isColored, isTree, isPlants, camDis, s_AtlasTexture);
  
  vec4 fogColor;
  fogColor.rgb = nlRenderSky(skycol, env, viewDir, FogColor.rgb, t);
  fogColor.a = nlRenderFogFade(relativeDist, FogColor.rgb, FogAndDistanceControl.xy);
  if(EGodRay)fogColor.a = mix(fogColor.a, 1.0, GodRay*nlRenderGodRayIntensity(cPos, worldPos, t, uv1, relativeDist, FogColor.rgb));
  
  if(ECloudyFog){
    float fg = smoothstep(0.0, 1.0-CloudyFog, relativeDist);
    fg *= sin(5.0*viewDir.y + 2.0*viewDir.x - 0.1*t);
    fg *= sin(5.0*viewDir.y - 2.0*viewDir.x + viewDir.z + 0.1*t);
    fogColor.a += (1.0-fogColor.a)*fg*fg;
  }
  
  color.rgb *= light;
  
  color0 = a_color0;
  color1 = color;
  vertColor = COLOR;
  fog = fogColor;
  cmPos = camPos;
  VERTEX = (VIEW_MATRIX*vec4(worldPos, 1.0)).xyz;
  NORMAL = normalize((MODEL_MATRIX * vec4(NORMAL, 0.0)).xyz);
  normal = NORMAL;
}

void fragment() {
  float ts = sin(TIME);
  vec4 diffuse = texture(s_AtlasTexture, UV);
  vec4 color = color1;
  
  if(diffuse.a < 0.5){
    discard;
  }
  
  // don't uncomment these lines!
  if((color0.g > color0.r) && Leaves){
    //diffuse.rgb *= mix(vec3(1.0,1.0,1.0), texture(s_SeasonsTexture, color0.xy).rgb, color0.z);
    //diffuse.rgb *= color.rgb * 2.0;
  }
  
  diffuse.rgb *= diffuse.rgb;
  
  vec3 lightTint = texture(s_LightMapTexture, vec2(0.0, 2.0)/vec2(textureSize(s_LightMapTexture, 0))).rgb;
  lightTint = mix(lightTint.bbb, lightTint*lightTint, 0.35 + 0.65*LightmapUV.y*LightmapUV.y*LightmapUV.y);
  color.rgb *= lightTint;
  
  diffuse.rgb *= color.rgb;
  
  diffuse.rgb = mix(diffuse.rgb, fog.rgb, fog.a);
  diffuse.rgb = colorCorrection(diffuse.rgb);
  ALBEDO = diffuse.rgb;
  ALPHA = diffuse.a;
}