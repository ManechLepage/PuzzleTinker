extends Node

@onready var tile_map = $"../TileMap"

func is_placeable(placementType: PlacementType.PlacementTypes, position: Vector2i):
	var ground_tiles = tile_map.get_used_cells(0)
	if position in ground_tiles:
		return false
	if placementType == PlacementType.PlacementTypes.Walls:
		return wall_placement(position)
	return true

func wall_placement(position: Vector2i):
	return has_wall_left(position) or has_wall_right(position)

func has_wall_left(position: Vector2i):
	var ground_tiles = tile_map.get_used_cells(0)
	var left_wall: Vector2i = position - Vector2i(1, 0)
	if left_wall in ground_tiles:
		return true

func has_wall_right(position: Vector2i):
	var ground_tiles = tile_map.get_used_cells(0)
	var right_wall: Vector2i = position + Vector2i(1, 0)
	if right_wall in ground_tiles:
		return true

func update_structure(structure: StructureScene):
	if structure.placement_type == PlacementType.PlacementTypes.Walls:
		update_sidewall_structure(structure)

func update_sidewall_structure(structure: StructureScene):
	var structure_position = tile_map.local_to_map(structure.global_position)
	if has_wall_left(structure_position):
		structure.get_node("SideWall").to_left()
	elif has_wall_right(structure_position):
		structure.get_node("SideWall").to_right()
