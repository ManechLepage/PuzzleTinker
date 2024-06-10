extends Control

@onready var item_name = $HBoxContainer/Button/ItemName
@onready var icon = $HBoxContainer/Button/Icon
@onready var quantity = $HBoxContainer/Button/Quantity

func load_item(name, _icon, _quantity):
	item_name.text = name
	icon.texture = _icon
	quantity.text = str(_quantity)
