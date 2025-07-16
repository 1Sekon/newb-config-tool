extends Node

var zenith : Dictionary = {
  "day": Vector3(0.15, 0.45, 1.0),
  "night": Vector3(0.004, 0.024, 0.04),
  "rain": Vector3(0.85, 0.9, 1.0),
  "end": Vector3(0.08, 0.001, 0.1),
  "dawn": Vector3(0.015, 0.045, 0.1),
}

var horizon : Dictionary = {
  "day": Vector3(0.53, 0.83, 0.93),
  "night": Vector3(0.01, 0.06, 0.1),
  "rain": Vector3(1.0, 1.0, 1.0),
  "end": Vector3(0.6, 0.02, 0.6),
  "dawn": Vector3(0.9, 0.3, 0.3),
}

var dawn_edge : Vector3 = Vector3(1.0, 0.4, 0.2)

func _on_day_zenith_color_changed(color: Color) -> void:
  zenith["day"] = Vector3(color.r, color.g, color.b)
  RenderingServer.global_shader_parameter_set(&"DayZenith", zenith["day"])


func _on_day_horizon_color_changed(color: Color) -> void:
  horizon["day"] = Vector3(color.r, color.g, color.b)
  RenderingServer.global_shader_parameter_set(&"DayHorizon", horizon["day"])


func _on_night_zenith_color_changed(color: Color) -> void:
  zenith["night"] = Vector3(color.r, color.g, color.b)
  RenderingServer.global_shader_parameter_set(&"NightZenith", zenith["night"])


func _on_night_horizon_color_changed(color: Color) -> void:
  horizon["night"] = Vector3(color.r, color.g, color.b)
  RenderingServer.global_shader_parameter_set(&"NightHorizon", horizon["night"])


func _on_rain_zenith_color_changed(color: Color) -> void:
  zenith["rain"] = Vector3(color.r, color.g, color.b)
  RenderingServer.global_shader_parameter_set(&"RainZenith", zenith["rain"])


func _on_rain_horizon_color_changed(color: Color) -> void:
  horizon["rain"] = Vector3(color.r, color.g, color.b)
  RenderingServer.global_shader_parameter_set(&"RainHorizon", horizon["rain"])


func _on_end_zenith_color_changed(color: Color) -> void:
  zenith["end"] = Vector3(color.r, color.g, color.b)
  RenderingServer.global_shader_parameter_set(&"EndZenith", zenith["end"])


func _on_en_horizon_color_changed(color: Color) -> void:
  horizon["end"] = Vector3(color.r, color.g, color.b)
  RenderingServer.global_shader_parameter_set(&"EndHorizon", horizon["end"])


func _on_dawn_zenith_color_changed(color: Color) -> void:
  zenith["dawn"] = Vector3(color.r, color.g, color.b)
  RenderingServer.global_shader_parameter_set(&"DawnZenith", zenith["dawn"])


func _on_dawn_edge_color_changed(color: Color) -> void:
  dawn_edge = Vector3(color.r, color.g, color.b)
  RenderingServer.global_shader_parameter_set(&"DawnEdge", dawn_edge)


func _on_dawn_horizon_color_changed(color: Color) -> void:
  horizon["dawn"] = Vector3(color.r, color.g, color.b)
  RenderingServer.global_shader_parameter_set(&"DawnHorizon", horizon["dawn"])
