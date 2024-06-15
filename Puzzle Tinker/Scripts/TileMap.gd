extends TileMap

var current_placeholder: StructureScene
var initialize_placeholder: bool = false

func place_structure(structure: Structure, position: Vector2):
	var structure_position = local_to_map(position)
	set_cell(1, structure_position, 1, Vector2(0, 0), 1)

func remove_structure(position: Vector2i):
	erase_cell(1, position)

func get_structure(structure_position: Vector2i):
	for structure in get_children():
		if local_to_map(structure.position) == structure_position:
			return structure
	return null

func create_placeholder(structure: Structure):
	set_cell(1, Vector2i(1000, 1000), 1, Vector2(0, 0), 1)
	initialize_placeholder = true

func _process(delta):
	if initialize_placeholder:
		initialize_placeholder = false
		current_placeholder = get_structure(Vector2i(1000, 1000))
		if current_placeholder:
			current_placeholder.placeholder()
	if current_placeholder:
		current_placeholder.position = map_to_local(local_to_map(get_global_mouse_position()))
		if local_to_map(current_placeholder.position) in get_used_cells(0):
			current_placeholder.placeholder_error()
		elif local_to_map(current_placeholder.position) in get_used_cells(0):
			current_placeholder.placeholder_error()
		else:
			current_placeholder.placeholder()

func clear_placeholder():
	if current_placeholder:
		current_placeholder.queue_free()
		current_placeholder = null
