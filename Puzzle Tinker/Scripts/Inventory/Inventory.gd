class_name Inventory
extends Node

var data: Dictionary
signal inventory_update(data)

@export var copper_block: Structure

func add_item(item: Item, count: int):
	if data.has(item):
		data[item] += count
		if data[item] < 1:
			data.erase(item)
	else:
		data[item] = count
	inventory_update.emit(data)

func _input(event):
	if Input.is_action_just_pressed("Test1"):
		add_item(copper_block, 1)
