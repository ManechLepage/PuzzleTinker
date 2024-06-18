extends Area2D

var strength: float = 700.0
var launch: bool = false
var player_in_area: bool = false
@onready var timer = $Timer

func _on_body_entered(body):
	if body.is_class("CharacterBody2D"):
		player_in_area = true

func _process(delta):
	if player_in_area and launch:
		get_tree().get_first_node_in_group("Player").launch(strength)

func _on_powered():
	timer.start()
	launch = true

func _on_timer_timeout():
	launch = false

func _on_body_exited(body):
	if body.is_class("CharacterBody2D"):
		player_in_area = false
