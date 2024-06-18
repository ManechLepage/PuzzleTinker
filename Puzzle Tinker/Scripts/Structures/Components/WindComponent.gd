extends Node2D

@onready var wind = $Wind
@onready var timer = $Timer

var bodies: Array[CollisionObject2D]
@export var strength: float
var is_powered: bool = false

func _on_powered():
	wind.visible = true
	is_powered = true
	timer.start()

func _on_timeout():
	wind.visible = false
	is_powered = false

func _on_area_2d_body_entered(body):
	bodies.append(body)

func _on_area_2d_body_exited(body):
	bodies.erase(body)

func _physics_process(delta):
	if is_powered:
		for body in bodies:
			body.velocity.y -= strength
