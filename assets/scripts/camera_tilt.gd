extends Node3D

@export var head : Node
@export var joystick_touch_pad : Control

var sensitivity = 2.5

func look(look_vector):
  look_vector = look_vector/ProjectSettings.get_setting("display/window/size/viewport_height")
  look_vector = look_vector*sensitivity
  
  rotate_y(look_vector.x)
  head.rotate_x(look_vector.y)
  head.rotation.x = clamp(head.rotation.x,deg_to_rad(-89),deg_to_rad(89))

func _physics_process(_delta):
  look(-joystick_touch_pad.get_touchpad_delta())
