@tool
extends Control

@export var update: bool = false
@export var tab_scene: PackedScene
@onready var blueprints_control = $VBoxContainer/Blueprints

func _process(delta):
	if update:
		update = false
		Update()

func Update():
	BlueprintManager.load_blueprints()
	
	for child in blueprints_control.get_children():
		if child.name != "Panel":
			child.queue_free()
	
	print("Updating tabs...")
	for tab in BlueprintManager.BlueprintTypes:
		var tab_preview = tab_scene.instantiate()
		tab_preview.load_tab(int(tab))
		blueprints_control.add_child(tab_preview)
