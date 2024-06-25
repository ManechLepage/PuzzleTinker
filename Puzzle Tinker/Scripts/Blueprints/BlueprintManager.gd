@tool
extends Node

var blueprints: Array[Blueprint]
var known_blueprints: Array[Blueprint]

@onready var blueprint_info = %BlueprintInfo

@export var cable: Blueprint

func load_blueprints():
	var file_paths = get_all_file_paths("res://Resources/Blueprints/")
	for file in file_paths:
		var blueprint: Blueprint = load(file)
		blueprints.append(blueprint)

func get_all_file_paths(path: String) -> Array[String]:  
	var file_paths: Array[String] = []  
	var dir = DirAccess.open(path)  
	dir.list_dir_begin()  
	var file_name = dir.get_next()  
	while file_name != "":  
		var file_path = path + "/" + file_name  
		if dir.current_is_dir():  
			file_paths += get_all_file_paths(file_path)  
		else:  
			file_paths.append(file_path)  
		file_name = dir.get_next()  
	return file_paths

func get_blueprint_from_item(item: Item, known: bool):
	if known:
		for blueprint in known_blueprints:
			if blueprint.item == item:
				return blueprint
	else:
		for blueprint in blueprints:
			if blueprint.item == item:
				return blueprint
	return null

func learn_blueprint(blueprint: Blueprint):
	blueprint_info.visible = true
	blueprint_info.load_blueprint(blueprint, true)
	known_blueprints.append(blueprint)

func _input(event):
	if Input.is_action_just_pressed("Test1"):
		learn_blueprint(cable)

func load_blueprint_info(item: Item):
	var blueprint: Blueprint = get_blueprint_from_item(item, true)
	blueprint_info.visible = true
	blueprint_info.load_blueprint(blueprint, false)
