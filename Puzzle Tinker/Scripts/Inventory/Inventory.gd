class_name Inventory
extends Node

var data: Dictionary
signal inventory_update(data)

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
