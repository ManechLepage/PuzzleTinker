@tool
extends HBoxContainer

@export var blueprint_preview_scene: PackedScene
@onready var blueprints = %Blueprints

signal load_new_blueprint_info(blueprint: Blueprint)

func load_tab(type: int):
	for child in get_children():
		child.queue_free()
	
	for blueprint in blueprints.blueprints:
		if int(blueprint.type) == type:
			load_blueprint(blueprint)

func load_blueprint(blueprint: Blueprint):
	var blueprint_preview = blueprint_preview_scene.instantiate()
	blueprint_preview.load_blueprint(blueprint)
	self.add_child(blueprint_preview)

func load_blueprint_info(blueprint: Blueprint):
	load_new_blueprint_info.emit(blueprint)
