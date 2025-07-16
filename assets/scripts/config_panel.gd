extends Control

func _ready() -> void:
  position.x = -1000
  $Container/ConfigContainer.reparent($Container/Scroll, false)
