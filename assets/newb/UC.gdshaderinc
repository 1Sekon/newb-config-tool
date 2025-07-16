uniform int TonemapType = 3;
uniform float Gamma = 1.33;
uniform bool EExposure = false;
uniform float Exposure = 1.3;
uniform bool ESaturation = false;
uniform float Saturation = 1.4;
uniform bool Tint = false;
uniform vec3 LTint = vec3(0.3,0.5,1.4);
uniform vec3 HTint = vec3(1.4,0.7,0.3);

uniform float SunIntensity = 2.95;
uniform float TorchIntensity = 1.0;
uniform float NightBrightness = 0.1;
uniform float CaveBrightness = 0.1;
uniform float ShadowIntensity = 0.7;
uniform bool BlinkingTorch = false;
uniform bool CloudShadow = false;

uniform vec3 MorningSunCol = vec3(1.0,0.45,0.14);
uniform vec3 NoonSunCol = vec3(1.0,0.75,0.57);
uniform vec3 NightSunCol = vec3(0.5,0.64,1.00);

uniform vec3 NetherAmbient = vec3(3.0,2.16,1.89);
uniform vec3 EndAmbient = vec3(1.98,1.25,2.3);

uniform vec3 OverworldTorchColor = vec3(1.0,0.52,0.18);
uniform vec3 UnderwaterTorchColor = vec3(1.0,0.52,0.18);
uniform vec3 NetherTorchColor = vec3(1.0,0.52,0.18);
uniform vec3 EndTorchColor = vec3(1.0,0.52,0.18);

uniform bool EFog = true;
uniform float Fog = 1.0;
uniform float MistDensity = 0.18;
uniform bool ERainMistOpacity = true;
uniform float RainMistOpacity = 0.12;
uniform bool ECloudyFog = true;
uniform float CloudyFog = 0.1;

uniform vec3 DayZenith = vec3(0.15,0.45,1.0);
uniform vec3 DayHorizon = vec3(0.53,0.83,0.93);
uniform vec3 NightZenith = vec3(0.004,0.024,0.04);
uniform vec3 NightHorizon = vec3(0.01,0.06,0.1);
uniform vec3 RainZenith = vec3(0.85,0.9,1.0);
uniform vec3 RainHorizon = vec3(1.0,1.0,1.0);
uniform vec3 EndZenith = vec3(0.08,0.001,0.1);
uniform vec3 EndHorizon = vec3(0.6,0.02,0.6);
uniform vec3 DawnZenith = vec3(0.015,0.045,0.1);
uniform vec3 DawnEdge = vec3(1.0,0.4,0.2);
uniform vec3 DawnHorizon = vec3(0.9,0.3,0.3);

uniform bool Rainbow = false;
uniform float RainbowClear = 0.0;
uniform float RainbowRain = 1.0;

uniform float GlowTex = 2.3;
uniform bool EGlowShimmer = true;
uniform float GlowShimmer = 0.8;
uniform float GlowShimmerSpeed = 0.9;
uniform bool EGlowLeak = false;
uniform float GlowLeak = 0.6;

uniform bool EPlantWave = true;
uniform float PlantWave = 0.05;
uniform bool ELanternWave = true;
uniform float LanternWave = 0.16;
uniform float WaveSpeed = 2.8;

uniform float WaterAlpha = 0.9;
uniform float WaterBump = 0.09;
uniform float WaterSpeed = 0.8;
uniform float WaterTexAlpha = 0.3;
uniform bool WaterWave = true;
uniform bool WaterReflection = true;
uniform bool WaterMask = false;
uniform vec3 WaterTint = vec3(0.52,0.9,0.45);

uniform float UnderwaterBrightness = 0.8;
uniform float CausticIntensity = 1.9;
uniform bool EUnderwaterWave = true;
uniform float UnderwaterWave = 0.1;
uniform bool EUnderwaterStreaks = true;
uniform float UnderwaterStreaks = 1.0;
uniform vec3 UnderwaterTint = vec3(0.9,1.0,0.9);

uniform int CloudType = 1;

uniform float Cloud0Thickness = 2.1;
uniform float Cloud0ThicknessRain = 4.0;
uniform float Cloud0Alpha = 0.9;
uniform bool Cloud0Multilayer = true;

uniform vec2 Cloud1Scale = vec2(0.016, 0.022);
uniform float Cloud1Depth = 1.3;
uniform float Cloud1Speed = 0.04;
uniform float Cloud1Density = 0.54;
uniform float Cloud1Alpha = 0.9;

uniform float Cloud2Thickness = 2.1;
uniform float Cloud2ThicknessRain = 2.5;
uniform int Cloud2Steps = 5;
uniform vec2 Cloud2Scale = vec2(0.033, 0.033);
uniform vec2 Cloud2Shape = vec2(0.5, 0.4);
uniform float Cloud2Density = 25.0;
uniform float Cloud2Velocity = 0.8;
uniform bool Cloud2Multilayer = false;
uniform float Cloud2LayerOffset = 143.0;
uniform float Cloud2LayerThickness = 2.5;
uniform float Cloud2LayerThicknessRain = 3.0;
uniform int Cloud2LayerSteps = 3;
uniform vec2 Cloud2LayerScale = vec2(0.03, 0.03);
uniform vec2 Cloud2LayerShape = vec2(0.5, 0.4);
uniform float Cloud2LayerDensity= 25.0;
uniform float Cloud2LayerVelocity = 0.8;

uniform vec2 Cloud3Scale = vec2(0.03, 0.03);
uniform float Cloud3Speed = 0.005;
uniform float Cloud3Shadow = 0.9;
uniform float Cloud3ShadowOffset = 0.3;

uniform bool EAurora = true;
uniform float Aurora = 1.2;
uniform float AuroraVelocity = 0.03;
uniform float AuroraScale = 0.04;
uniform float AuroraWidth = 0.18;
uniform vec3 AuroraCol1 = vec3(0.1,1.0,0.0);
uniform vec3 AuroraCol2 = vec3(0.1,0.0,1.0);

uniform bool EShootingStar = true;
uniform float ShootingStar = 1.0;
uniform float ShootingStarPeriod = 6.0;
uniform float ShootingStarDelay = 64.0;

uniform bool EGalaxyStars = false;
uniform float GalaxyStars = 2.0;
uniform float GalaxyVibrance = 0.7;
uniform float GalaxySpeed = 0.03;
uniform float GalaxyDay = 0.0;

uniform bool ESunMoonAngle = false;
uniform float SunMoonAngle = 45.0;
uniform float SunMoonSize = 1.0;
uniform float SunMoonRain =  0.5;

uniform bool EGodRay = false;
uniform float GodRay = 0.3;

uniform bool EGroundRefl = false;
uniform float GroundRefl = 0.4;
uniform float RainWetness = 1.0;
uniform float RainPuddles = 0.7;
uniform bool GroundAurora = false;

uniform float EntityBrighness = 0.65;
uniform float EntityEdge = 0.41;

uniform bool EWeatherSpeck = true;
uniform float WeatherSpeck = 0.6;
uniform float RainSlant = 4.0;
uniform float RainParticleSize = 1.0;

uniform bool LavaNoise = true;
uniform bool ELavaBump = false;
uniform float LavaBump = 0.2;
uniform float LavaNoiseSpeed = 0.02;