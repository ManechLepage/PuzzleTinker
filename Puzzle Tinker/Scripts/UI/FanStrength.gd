extends TextureRect

@export var textures: SpriteFrames
var current_index: int = 1

func _ready():
	set_frame(1)

func set_frame(index):
	texture = textures.get_frame_texture("default", index)


func _on_gui_input(event):
	if Input.is_action_just_pressed("Left Click"):
		current_index += 1
		set_frame(current_index % 3)
		get_parent().get_parent().changed_strength.emit(current_index % 3)
