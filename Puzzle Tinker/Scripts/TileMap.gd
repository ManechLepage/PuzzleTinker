extends TileMap


func place_structure(structure: Structure, position: Vector2):
	var structure_position = local_to_map(position)
	set_cell(1, structure_position, 1, Vector2(0, 0), 1)
