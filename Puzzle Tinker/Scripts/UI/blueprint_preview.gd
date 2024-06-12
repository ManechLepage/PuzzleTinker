@tool
extends Button

var current_blueprint: Blueprint

func load_blueprint(blueprint: Blueprint):
	current_blueprint = blueprint
	get_child(0).text = blueprint.item.name

func _on_pressed():
	get_parent().load_blueprint_info(current_blueprint)
