extends State

@export var jump: State
@export var run: State
@export var fall: State
@export var mine: State

func enter():
	super()
	parent.velocity.x = 0

func process_inputs(event):
	if Input.is_action_just_pressed("Jump") and parent.is_on_floor():
		return jump
	if Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right"):
		return run
	if Input.is_action_just_pressed("Left Click"):
		if can_mine():
			return mine
	return null

func process_physics(delta):
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	if parent.velocity.y > 0:
		return fall
	
	var movement = Input.get_axis("Left", "Right") * move_speed
	if movement != 0:
		return run
	return null
