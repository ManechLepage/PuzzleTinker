@tool
extends Node

var blueprints: Array[Blueprint]

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
