class_name State
extends Node

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

var move_speed: float = 400

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
