extends State

@export var idle: State
@export var jump: State
@export var run: State

var currently_placing: Structure

signal place_block(structure: Structure)
signal initialize_placeholder(structure: Structure)

func enter():
	super()
	initialize_placeholder.emit(currently_placing)

func exit():
	parent.remove_placeholder()
	place_block.emit(currently_placing)
	parent.inventory.add_item(currently_placing, -1)

func process_inputs(event):
	#if Input.is_action_just_pressed("Jump") and parent.is_on_floor():
		#return jump
	#if Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right"):
		#return run
	if Input.is_action_just_pressed("Left Click"):
		if parent.tile_map.current_placeholder.can_place:
			return idle
	return null
