extends TileMap

var current_placeholder: StructureScene
var initialize_placeholder: bool = false

@onready var cables = $Cables

func place_structure(structure: Structure, position: Vector2):
	var structure_position = local_to_map(position)
	set_cell(1, structure_position, 1, Vector2(0, 0), structure.structure_id)

func remove_structure(position: Vector2i):
	erase_cell(1, position)

func get_structure(structure_position: Vector2i):
	for structure in get_children():
		if local_to_map(structure.global_position) == structure_position:
			return structure
	return null

func create_placeholder(structure: Structure):
	set_cell(1, Vector2i(1000, 1000), 1, Vector2(0, 0), structure.structure_id)
	initialize_placeholder = true

func finish_cable_placing():
	erase_cell(1, Vector2i(1000, 1000))
	if current_placeholder:
		current_placeholder.editing = false
	current_placeholder = null

func _process(delta):
	if initialize_placeholder:
		initialize_placeholder = false
		current_placeholder = get_structure(Vector2i(1000, 1000))
		if current_placeholder:
			if current_placeholder.placeholder:
				current_placeholder.get_node("Placeholder").placeholder()
			else:
				current_placeholder.global_position = get_global_mouse_position()
				current_placeholder.cable_component.start.global_position = get_structure(local_to_map(current_placeholder.position)).get_node("PowerPosition").global_position
	if current_placeholder:
		if current_placeholder.placeholder:
			current_placeholder.position = map_to_local(local_to_map(get_global_mouse_position()))
			if local_to_map(current_placeholder.position) in get_used_cells(0):
				current_placeholder.get_node("Placeholder").placeholder_error()
			elif local_to_map(current_placeholder.position) in get_used_cells(0):
				current_placeholder.get_node("Placeholder").placeholder_error()
			else:
				current_placeholder.get_node("Placeholder").placeholder()
			if current_placeholder.connect_to_ground:
				current_placeholder.get_node("ConnectToGround").to_ground()
		else:
			if current_placeholder.editing:
				var structure = get_structure(local_to_map(get_global_mouse_position()))
				var pos: Vector2
				if structure:
					if structure.has_power:
						pos = structure.get_node("PowerPosition").global_position
					else:
						pos = get_global_mouse_position()
				else:
					pos = get_global_mouse_position()
				
				if current_placeholder.cable_component.is_in_range:
					current_placeholder.cable_component.last.global_position = pos
				else:
					pass

func clear_placeholder():
	if current_placeholder:
		if current_placeholder.placeholder:
			current_placeholder.queue_free()
		current_placeholder = null
		erase_cell(1, Vector2i(1000, 1000))

func can_place_cable():
	for structure in get_children():
		if structure.position == map_to_local(local_to_map(get_global_mouse_position())):
			if structure.has_power:
				return true
	return false
