extends State

@export var idle: State
@export var jump: State
@export var run: State
var currently_placing: Structure
signal place_block(structure: Structure)

func enter():
	super()

func process_inputs(event):
	if Input.is_action_just_pressed("Jump") and parent.is_on_floor():
		return jump
	if Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right"):
		return run
	if Input.is_action_just_pressed("Left Click"):
		place_block.emit(currently_placing)
		parent.inventory.add_item(currently_placing, -1)
		return idle
	return null
