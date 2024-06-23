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
	var item_preview = blueprint_preview_scene.instantiate()
	self.add_child(item_preview)
	item_preview.load_item(blueprint.item).connect(load_blueprint_info)

func load_blueprint_info(item: Item):
	var blueprint = blueprints.get_blueprint_from_item(item)
	load_new_blueprint_info.emit(blueprint)
