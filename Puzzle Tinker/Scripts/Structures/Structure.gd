class_name StructureScene
extends Node2D

var ui: Control
var is_placeholder: bool = false

@onready var animated_sprite_2d = $AnimatedSprite2D

func enable_ui():
	ui = get_node("Selectable").UI.instantiate()
	get_tree().get_first_node_in_group("UI").add_child(ui)

func disable_ui():
	ui.queue_free()

func placeholder():
	is_placeholder = true
	set_tint()
	var tween = create_tween()
	tween.tween_method(change_tint_fade, 1.0, 0.5, 0.5)

func set_tint():
	animated_sprite_2d.material.set_shader_parameter("tint_factor", 0.6)

func change_tint_fade(value: float):
	animated_sprite_2d.material.set_shader_parameter("fade", value)
