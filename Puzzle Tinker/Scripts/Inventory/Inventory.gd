class_name Inventory
extends Node

var data: Dictionary
signal inventory_update(data)

func add_item(item: Item, count: int):
	if data.has(item):
		data[item] += count
	else:
		data[item] = count
	inventory_update.emit(data)
