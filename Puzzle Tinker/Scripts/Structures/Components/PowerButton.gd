extends Node

@onready var animated_sprite_2d = $"../AnimatedSprite2D"
@onready var timer = $Timer
@onready var power = $"../Power"

func _disabled():
	pass

func _enabled():
	animated_sprite_2d.set_frame_and_progress(1, 0.0)
	timer.start()
	power.receive_power()

func _timeout():
	animated_sprite_2d.set_frame_and_progress(0, 0.0)
	get_tree().get_first_node_in_group("Player").remove_structure_ui()
