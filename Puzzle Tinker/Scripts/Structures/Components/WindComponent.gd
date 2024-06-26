extends Node2D

@onready var wind = $Wind
@onready var timer = $Timer

var bodies: Array[CollisionObject2D]
@export var strength: Vector2
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
			if body.is_in_group("Player"):
				body.velocity -= strength
			elif body.is_in_group("Pushable"):
				body.apply_central_force(Vector2(100, -100))

func _update_to_right():
	strength *= -1

func _update_to_left():
	strength *= -1
