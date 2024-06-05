extends Node

@export var starting_state: State
var current_state: State

func init(player: Player):
	for child in get_children():
		child.parent = player
	
	change_state(starting_state)

func change_state(new_state: State):
	if current_state:
		current_state.exit()
	
	current_state = new_state
	current_state.enter()

func process_frame(delta):
	var new_state = current_state.process_frames(delta)
	if new_state:
		change_state(new_state)

func process_physics(delta):
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)

func process_inputs(delta):
	var new_state = current_state.process_inputs(delta)
	if new_state:
		change_state(new_state)
