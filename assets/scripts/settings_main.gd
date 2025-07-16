extends Control


func _on_close_button_pressed() -> void:
  var tween = get_node(^"MarginContainer").create_tween().set_ease(Tween.EASE_IN)
  tween.tween_property(get_node(^"MarginContainer"), "position", Vector2(0.0, 1000.0), 0.2).set_trans(Tween.TRANS_EXPO)
  tween.parallel().tween_property(get_node(^"MarginContainer"), "visible", false, 0.2).set_trans(Tween.TRANS_EXPO)
  tween.parallel().tween_property(get_node(^"ColorRect"), "modulate", Color(1, 1, 1, 0), 0.3).set_trans(tween.TRANS_SINE)
