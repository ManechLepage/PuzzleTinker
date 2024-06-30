extends Node2D

@onready var phantom_camera_2d = $PhantomCamera2D
@export var background: Background
@onready var background_node = %Background

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		if background:
			background_node.load_background(background, position)
		phantom_camera_2d.priority = 1


func _on_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		phantom_camera_2d.priority = 0
