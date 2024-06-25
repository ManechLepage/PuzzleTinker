extends State

@export var idle: State

var is_idle: bool = false
var structure: StructureScene

func enter():
	super()
	if parent.current_selected_structure == null:
		is_idle = true
		structure = null
	else:
		structure = parent.current_selected_structure
		if structure.get_node("Selectable").zoom:
			parent.camera_manager.zoom_on_structure(structure.position)
		structure.enable()


func exit():
	super()
	if structure:
		structure.disable()
		parent.camera_manager.unzoom()
		structure = null

func process_frames(delta):
	if is_idle:
		return idle
	return null

func process_inputs(event):
	if Input.is_action_just_pressed("Escape"):
		return idle
	return null

func _on_player_update_structure_menu():
	is_idle = true
