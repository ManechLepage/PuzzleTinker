extends State

@export var idle: State
@export var run: State
@export var fall: State

@export var jump_force: float = 500.0

func enter():
	super()
	parent.velocity.y = -jump_force

func process_physics(delta):
	parent.velocity.y += gravity * delta
	
	var movement = Input.get_axis("Left", "Right") * move_speed
	
	if movement != 0:
		pass # Flip animation
	
	parent.velocity.x = movement
	parent.move_and_slide()
	
	if parent.velocity.y > 0:
		return fall
	
	if parent.is_on_floor():
		if movement != 0:
			return run
		return idle
	return null
