extends Area2D

@export var strength: Vector2
var launch: bool = false
var player_in_area: bool = false
@onready var timer = $Timer
var bodies: Array[RigidBody2D]
var has_launched_bodies: Array[bool]

func _on_body_entered(body):
	if body.is_class("CharacterBody2D"):
		player_in_area = true
	elif body.is_in_group("Pushable"):
		bodies.append(body)
		has_launched_bodies.append(false)

func _process(delta):
	if launch:
		if player_in_area:
			get_tree().get_first_node_in_group("Player").launch(strength)
		for body in range(len(bodies)):
			if not has_launched_bodies[body]:
				bodies[body].apply_central_impulse(strength * 8)
				has_launched_bodies[body] = true

func _on_powered():
	timer.start()
	launch = true

func _on_timer_timeout():
	launch = false
	for body in range(len(bodies)):
		has_launched_bodies[body] = false

func _on_body_exited(body):
	if body.is_class("CharacterBody2D"):
		player_in_area = false
	elif body.is_in_group("Pushable"):
		var index = bodies.find(body)
		bodies.remove_at(index)
		has_launched_bodies.remove_at(index)

func update_side():
	strength *= -1
