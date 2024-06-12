extends Control

@onready var material_selection = $MaterialSelection

func _input(event):
	if Input.is_action_just_pressed("Test1"):
		visible = !visible

func _on_pressed(is_top):
	material_selection.visible = true
