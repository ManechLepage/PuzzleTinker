extends Node

@export var sprite: AnimatedSprite2D
var is_reverse: bool = false

func change_animation():
	sprite.play("default")

func _on_animated_sprite_2d_animation_looped():
	sprite.stop()
