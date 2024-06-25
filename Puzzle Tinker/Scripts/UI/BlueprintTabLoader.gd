@tool
extends HBoxContainer

@export var blueprint_preview_scene: PackedScene
@onready var blueprints = %Blueprints

signal build_blueprints(blueprint: Blueprint)

func load_tab(type: int):
	for child in get_children():
		child.queue_free()
	
	for blueprint in blueprints.known_blueprints:
		if int(blueprint.type) == type:
			load_blueprint(blueprint)

func load_blueprint(blueprint: Blueprint):
	var item_preview = blueprint_preview_scene.instantiate()
	self.add_child(item_preview)
	item_preview.load_item(blueprint.item).connect(build_blueprint)
	item_preview.get_info.connect(load_blueprint_info)

func build_blueprint(item: Item):
	var blueprint = blueprints.get_blueprint_from_item(item, true)
	build_blueprints.emit(blueprint)

func load_blueprint_info(item: Item):
	blueprints.load_blueprint_info(item)
