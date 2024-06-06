class_name State
extends Node

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

var move_speed: float = 225

var parent: Player

func enter():
	pass # Add animations

func exit():
	pass

func process_inputs(event):
	return null

func process_frames(delta):
	return null

func process_physics(delta):
	return null

func flip_character(movement):
	if movement < 0 and !parent.facing_right:
		parent.facing_right = true
	elif movement > 0 and parent.facing_right:
		parent.facing_right = false
	parent.sprite_2d.flip_h = parent.facing_right
