extends Node

var ui: Control
@export var UI: PackedScene

func _enabled():
	ui = UI.instantiate()
	get_tree().get_first_node_in_group("UI").add_child(ui)

func _disabled():
	ui.queue_free()
