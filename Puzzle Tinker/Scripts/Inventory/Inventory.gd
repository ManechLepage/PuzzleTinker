class_name Inventory
extends Node

@export var iron: Item

var data: Dictionary
signal inventory_update(data)


func _input(event):
	if Input.is_action_just_pressed("Test1"):
		add_item(iron, 100)

func add_item(item: Item, count: int):
	if data.has(item):
		data[item] += count
		if data[item] < 1:
			data.erase(item)
	else:
		data[item] = count
	inventory_update.emit(data)

func can_build(blueprint: Blueprint):
	for i in blueprint.craft:
		if data.has(i.item):
			if data[i.item] < i.quantity:
				return false
		else:
			return false
	return true
