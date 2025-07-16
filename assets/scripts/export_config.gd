extends Button

@export var cnfg : Control


func _on_pressed() -> void:
  $"../ExportConfigWindow".visible = true


func _on_export_config_window_dir_selected(dir: String) -> void:
  var config_path = dir + "/%s.cfg" % ["test"]
  cnfg.save_config(config_path)
  print(config_path)
