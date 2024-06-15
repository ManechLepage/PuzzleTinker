extends Node2D

@export var middle: PackedScene

func to_ground(ground_tiles: Array[Vector2i], structure_tiles: Array[Vector2i], tile_position: Vector2i):
	for child in get_children():
		child.queue_free()
	
	var is_on_ground: bool = false
	var last_position: Vector2i = tile_position
	var positions: Array[Vector2i]
	
	while not is_on_ground:
		positions.append(last_position)
		last_position -= Vector2i(0, 1)
		if last_position in ground_tiles:
			is_on_ground = true
		if last_position in structure_tiles:
			is_on_ground = true
	
	for pos in positions:
		if pos != tile_position:
			var part = middle.instantiate()
			add_child(part)
			part.position = get_tree().get_first_node_in_group("TileMap").map_to_local(pos)
