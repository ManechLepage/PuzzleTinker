@tool
extends VBoxContainer

@export var blueprint_preview_scene: PackedScene

func load_tab(type: int):
	for blueprint in BlueprintManager.blueprints:
		if int(blueprint.type) == type:
			load_blueprint(blueprint)

func load_blueprint(blueprint: Blueprint):
	var blueprint_preview = blueprint_preview_scene.instantiate()
	add_child(blueprint_preview)
