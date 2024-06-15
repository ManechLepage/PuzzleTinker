extends Node2D

var is_placeholder: bool = false
var can_place: bool

var placeholder_color = Color(0.276, 0.423, 0.75)
var placeholder_error_color = Color(0.737, 0.2, 0.322)

@export var sprite: AnimatedSprite2D

func placeholder():
	can_place = true
	is_placeholder = true
	set_tint()
	#var tween = create_tween()
	#tween.tween_method(change_tint_fade, 1.0, 0.5, 0.5)

func placeholder_error():
	can_place = false
	set_error_tint()

func set_tint():
	sprite.material.set_shader_parameter("tint_factor", 0.6)
	sprite.material.set_shader_parameter("color", placeholder_color)

func set_error_tint():
	sprite.material.set_shader_parameter("color", placeholder_error_color)

func change_tint_fade(value: float):
	sprite.material.set_shader_parameter("fade", value)

