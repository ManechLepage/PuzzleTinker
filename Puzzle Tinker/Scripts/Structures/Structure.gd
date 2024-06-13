class_name StructureScene
extends Node2D

var ui: Control

func enable_ui():
	ui = get_node("Selectable").UI.instantiate()
	get_tree().get_first_node_in_group("UI").add_child(ui)

func disable_ui():
	ui.queue_free()
