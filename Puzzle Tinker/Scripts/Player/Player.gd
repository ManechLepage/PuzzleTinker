class_name Player
extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_jumped: bool = false
var facing_right: bool = true

@onready var sprite_2d = $Sprite2D
@onready var state_machine = $StateMachine

func _ready():
	state_machine.init(self)

func _physics_process(delta):
	state_machine.process_physics(delta)

func _process(delta):
	state_machine.process_frame(delta)

func _unhandled_input(event):
	state_machine.process_inputs(event)
