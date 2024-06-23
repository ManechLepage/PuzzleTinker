extends State

@export var gravity_multiplier: float = 1.8

@onready var timer = $CoyoteJump
@onready var input_delay_timer = $InputDelay

@export var jump: State
@export var run: State
@export var idle: State

var can_control: bool = true

func enter():
	timer.start()
	super()

func exit():
	if parent.is_on_floor():
		parent.ground_impact_particles.emitting = true
	can_control = true

func process_inputs(event):
	if Input.is_action_just_pressed("Jump"):
		if timer.time_left > 0 and !parent.has_jumped:
			return jump
		else:
			input_delay_timer.start()
	if Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right"):
		return run
	return null

func process_physics(delta):
	var movement = Input.get_axis("Left", "Right") * move_speed
	flip_character(movement)
	
	parent.velocity.y += gravity * delta * gravity_multiplier
	if can_control:
		parent.velocity.x = movement
	parent.move_and_slide()
	
	if parent.is_on_floor():
		parent.has_jumped = false
		if input_delay_timer.time_left > 0:
			return jump
		if movement != 0:
			return run
		return idle
	return null
