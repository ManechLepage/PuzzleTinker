extends Node2D

@onready var phantom_camera_2d = $PhantomCamera2D

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		phantom_camera_2d.priority = 1


func _on_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		phantom_camera_2d.priority = 0
