class_name CameraManager
extends Node2D

@onready var structure_ui_camera = %StructureUICamera

func zoom_on_structure(structure_position: Vector2):
	structure_ui_camera.position = structure_position
	structure_ui_camera.priority = 10

func unzoom():
	structure_ui_camera.priority = 0
