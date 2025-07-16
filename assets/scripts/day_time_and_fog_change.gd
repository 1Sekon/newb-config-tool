@tool
extends Node3D

var fog_color : Dictionary = {
  "day": Vector3(0.66666666667, 0.81960784314, 0.99607843137), 
  "rainDay": Vector3(0.4, 0.4, 0.4), 
  "dawn": Vector3(0.76470588235, 0.38039215686, 0.25490196078), 
  "night": Vector3(0.03921568627, 0.04705882353, 0.0862745098), 
  "rainNight": Vector3(0.02352941176, 0.02352941176, 0.03529411765), 
  "end": Vector3(0.25098039216, 0.0, 0.25098039216),
  }

var fog_control : Dictionary = {
  "day": Vector2(0.70980392157, 0.98823529412), 
  "rainDay" : Vector3(0.23137254902, 0.70196078431, 1.0), 
  "night": Vector2(0.70980392157, 0.99215686275), 
  "rainNight" : Vector3(0.23137254902, 0.70196078431, 1.0), 
  "underwater" : Vector3(0.0, 0.16862745098, 1.0), 
  "end" : Vector3(0.70980392157, 0.98823529412, 1.0), 
  "netherWastes" : Vector3(0.10588235294, 1.0, 1.0),
}

var fc : Vector3 = fog_color["day"]
var fct : Vector2 = fog_control["day"]

func _process(delta: float) -> void:
  if not Engine.is_editor_hint():
    rotate_z(delta*0.5)
  var t = rotation.z
  var tdeg = rad_to_deg(t)
  
  if tdeg >= 0 and tdeg <= 45: # dawn > day
    fc = lerp(fog_color["dawn"], fog_color["day"], tdeg/45)
    
  elif tdeg >= 135 and tdeg <= 180: # day > dawn
    fc = lerp(fog_color["dawn"], fog_color["day"], (180 - tdeg)/45)
    
  elif tdeg <= 180 and tdeg <= -135: # dawn > night
    fc = lerp(fog_color["dawn"], fog_color["night"], (-180 - tdeg)/-45)
    fct = lerp(fog_control["day"], fog_control["night"], (-180 - tdeg)/-45)
  
  elif tdeg <= 0 and tdeg >= -45: # night > dawn
    fc = lerp(fog_color["dawn"], fog_color["night"], tdeg/-45)
    fct = lerp(fog_control["day"], fog_control["day"], tdeg/-45)
  
  #set fog color
  RenderingServer.global_shader_parameter_set(&"FogColor", fc)
  
  #set fog control and the distance
  #RenderingServer.global_shader_parameter_set(&"FogAndDistanceControl", Vector3(fct.x, fct.y, 12.0))
 # $"../Cam/Label".text = str(fct)
