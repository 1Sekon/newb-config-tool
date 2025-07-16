extends VBoxContainer

var plantw_on : bool = true
var plant_wave_val : float = 0.05
var lanternw_on : bool = true
var lantern_wave_val : float = 0.16
var wave_speed : float = 2.8
var wave_range : float = 13.0

func _on_p_wave_toggle_toggled(toggled_on: bool) -> void:
  plantw_on = toggled_on
  RenderingServer.global_shader_parameter_set(&"EPlantWave", toggled_on)


func _on_plant_wave_text_changed(new_text: String) -> void:
  plant_wave_val = type_convert(new_text, TYPE_FLOAT)
  RenderingServer.global_shader_parameter_set(&"PlantWave", type_convert(new_text, TYPE_FLOAT))


func _on_l_wave_toggle_toggled(toggled_on: bool) -> void:
  lanternw_on = toggled_on
  RenderingServer.global_shader_parameter_set(&"ELanternWave", toggled_on)


func _on_lantern_wave_text_changed(new_text: String) -> void:
  lantern_wave_val = type_convert(new_text, TYPE_FLOAT)
  RenderingServer.global_shader_parameter_set(&"LanternWave", type_convert(new_text, TYPE_FLOAT))


func _on_wave_speed_text_changed(new_text: String) -> void:
  wave_speed = type_convert(new_text, TYPE_FLOAT)
  RenderingServer.global_shader_parameter_set(&"WaveSpeed", type_convert(new_text, TYPE_FLOAT))


func _on_wave_range_text_changed(new_text: String) -> void:
  wave_range = type_convert(new_text, TYPE_FLOAT)
  RenderingServer.global_shader_parameter_set(&"WaveRange", type_convert(new_text, TYPE_FLOAT))
