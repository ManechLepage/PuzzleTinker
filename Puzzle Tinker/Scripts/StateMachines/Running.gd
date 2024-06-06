extends State

@export var jump: State
@export var idle: State
@export var fall: State


func process_inputs(event):
	if Input.is_action_just_pressed("Jump") and parent.is_on_floor():
		return jump

func process_physics(delta):
	var movement = Input.get_axis("Left", "Right") * move_speed
	
	flip_character(movement)
	
	parent.velocity.x = movement
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	if movement == 0:
		return idle
	if parent.velocity.y > 0:
		return fall
	return null
