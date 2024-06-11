extends Control

@export var item_name: Label
@export var icon: TextureRect
@export var quantity : Label
var item: Item

signal initialize_building_mode(structure: Structure)

func load_item(_item, name, _icon, _quantity):
	item = _item
	item_name.text = name
	icon.texture = _icon
	quantity.text = str(_quantity)

func _on_button_pressed():
	initialize_building_mode.emit(item as Structure)
