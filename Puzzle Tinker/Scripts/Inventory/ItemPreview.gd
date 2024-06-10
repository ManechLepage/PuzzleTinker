extends Control

@onready var item_name = $HBoxContainer/ItemName
@onready var icon = $HBoxContainer/Icon
@onready var quantity = $HBoxContainer/Quantity

func load_item(name, _icon, _quantity):
	item_name.text = name
	icon.texture = _icon
	quantity.text = str(_quantity)
