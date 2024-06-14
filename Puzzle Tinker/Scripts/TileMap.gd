extends TileMap


func place_structure(structure: Structure, position: Vector2, placeholder):
	var structure_position = local_to_map(position)
	set_cell(1, structure_position, 1, Vector2(0, 0), 1)
	if placeholder:
		var structure_scene: StructureScene = get_structure(structure_position)
		if structure_scene:
			structure_scene.placeholder()

func remove_structure(position: Vector2i):
	erase_cell(1, position)

func get_structure(structure_position: Vector2i):
	for structure in get_children():
		if local_to_map(structure.position) == structure_position:
			return structure
	return null
