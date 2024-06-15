extends State

@export var idle: State
@export var jump: State
@export var run: State

var currently_placing: Structure
var click: int = 0

signal place_block(structure: Structure)
signal initialize_placeholder(structure: Structure)

signal place_cable(cable: Cable)
signal finish_cable_placing

func enter():
	super()
	if currently_placing.structure_id == 0:
		pass
	else:
		initialize_placeholder.emit(currently_placing)

func exit():
	if currently_placing.structure_id == 0:
		click = 0
		finish_cable_placing.emit()
	else:
		parent.remove_placeholder()
		place_block.emit(currently_placing)
	parent.inventory.add_item(currently_placing, -1)

func process_inputs(event):
	#if Input.is_action_just_pressed("Jump") and parent.is_on_floor():
		#return jump
	#if Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right"):
		#return run
	if Input.is_action_just_pressed("Left Click"):
		if currently_placing.structure_id == 0:
			if click == 0:
				if parent.tile_map.can_place_cable():
					click += 1
					place_cable.emit(currently_placing)
			else:
				if parent.tile_map.can_place_cable():
					return idle
		else:
			if parent.tile_map.current_placeholder.get_node("Placeholder").can_place:
				return idle
	return null
