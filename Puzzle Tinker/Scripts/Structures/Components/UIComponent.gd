extends Node

var ui: Control
@export var UI: PackedScene

func _ready():
	ui = UI.instantiate()
	get_tree().get_first_node_in_group("UI").add_child(ui)
	if get_child(0):
		ui.changed_strength.connect(get_child(0).update_fan)
	ui.visible = false

func _enabled():
	ui.visible = true

func _disabled():
	ui.visible = false
