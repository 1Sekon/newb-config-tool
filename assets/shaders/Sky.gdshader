shader_type sky;

#include "res://assets/newb/material/sky.gdshaderinc"
global uniform vec3 FogAndDistanceControl;
global uniform vec3 FogColor;

void sky() {
    nl_environment env = nlDetectEnvironment(FogColor, FogAndDistanceControl);

    nl_skycolor skycol;
    skycol = nlOverworldSkyColors(env.rainFactor, FogColor);
    vec3 skyColor = nlRenderSky(skycol, env, -EYEDIR, FogColor, TIME);
    skyColor = colorCorrection(skyColor);
    COLOR = skyColor;
}
