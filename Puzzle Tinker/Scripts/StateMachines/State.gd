class_name State
extends Node

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

var move_speed: float = 110

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
	parent.sprite.flip_h = parent.facing_right

func can_mine():
	var player_tile_map_pos = parent.tile_map.local_to_map(parent.position)
	for tile in parent.tile_map.get_surrounding_cells(player_tile_map_pos):
		var tile_data = parent.tile_map.get_cell_tile_data(0, tile)
		if tile_data:
			if tile_data.get_custom_data("mineral"):
				return true
	return false
