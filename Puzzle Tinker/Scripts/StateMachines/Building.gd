extends State

@export var idle: State
@export var jump: State
@export var run: State
var currently_placing: Structure
var current_placeholder_position: Vector2i
signal place_block(structure: Structure, last_placeholder: Vector2i)

func enter():
	super()

func exit():
	current_placeholder_position = Vector2i(1000, 1000)
	place_block.emit(currently_placing, null)
	parent.inventory.add_item(currently_placing, -1)

func process_inputs(event):
	if Input.is_action_just_pressed("Jump") and parent.is_on_floor():
		return jump
	if Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right"):
		return run
	if Input.is_action_just_pressed("Left Click"):
		return idle
	return null

func process_frames(delta):
	var placeholder_position: Vector2i = parent.tile_map.local_to_map(parent.get_global_mouse_position())
	if placeholder_position != current_placeholder_position:
		place_block.emit(currently_placing, current_placeholder_position)
		current_placeholder_position = placeholder_position
