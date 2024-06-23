class_name CableManager
extends Node2D

@export var cable_scene: PackedScene
@onready var tile_map = $"../TileMap"

var current_cable: Cable

func can_place_cable():
	for structure in tile_map.get_children():
		if tile_map.local_to_map(structure.global_position) == tile_map.local_to_map(get_global_mouse_position()):
			if structure.has_power:
				return true
	return false

func place_cable():
	current_cable = cable_scene.instantiate()
	var first_structure = tile_map.get_structure(tile_map.local_to_map(get_global_mouse_position()))
	current_cable.global_position = first_structure.get_node("Power").global_position
	add_child(current_cable)
	print(first_structure.name)
	first_structure.get_node("Power").send_power.connect(current_cable.cable_component.power)

func _process(delta):
	if current_cable:
		var structure = tile_map.get_structure(tile_map.local_to_map(get_global_mouse_position()))
		var pos: Vector2
		if structure:
			if structure.has_power:
				pos = structure.get_node("Power").global_position
			else:
				pos = get_global_mouse_position()
		else:
			pos = get_global_mouse_position()
		
		if current_cable.cable_component.is_in_range:
			current_cable.cable_component.last.global_position = pos
			current_cable.cable_component.set_to_default_color()
		else:
			current_cable.cable_component.set_to_error_color()

func finish_cable_placing():
	if current_cable:
		var structure = tile_map.get_structure(tile_map.local_to_map(get_global_mouse_position()))
		current_cable.editing = false
		print(structure.name)
		current_cable.cable_component.end_powered.connect(structure.get_node("Power").receive_power)
	current_cable = null
