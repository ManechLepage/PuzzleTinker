extends Node2D

var starting_position: Vector2 = Vector2.ZERO
var end_position: Vector2 = Vector2.ZERO

@export var rope: PackedScene

func _input(event):
	if Input.is_action_just_pressed("Left Click"):
		if starting_position != Vector2.ZERO:
			end_position = get_global_mouse_position()
			var rope_scene = rope.instantiate()
			add_child(rope_scene)
			rope_scene.get_child(-1).spawn_cable(starting_position, end_position)
			starting_position = Vector2.ZERO
			end_position = Vector2.ZERO
		else:
			starting_position = get_global_mouse_position()
