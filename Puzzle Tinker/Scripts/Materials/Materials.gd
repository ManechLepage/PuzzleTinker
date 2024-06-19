class_name Materials
extends Node

@export var data: Array[MiningMaterial]

func get_material_from_id(id: int):
	for mat in data:
		if mat.id == id:
			return mat
	return null
