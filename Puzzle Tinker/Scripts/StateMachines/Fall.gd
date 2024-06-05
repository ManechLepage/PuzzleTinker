extends State

@export var jump: State
@export var run: State
@export var idle: State

func enter():
	super()

func process_inputs(event):
	if Input.is_action_just_pressed("Jump") and parent.is_on_floor():
		return jump
	if Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right"):
		return run
	return null

func process_physics(delta):
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	var movement = Input.get_axis("Left", "Right") * move_speed
	if parent.is_on_floor():
		if movement != 0:
			return run
		return idle
	return null
