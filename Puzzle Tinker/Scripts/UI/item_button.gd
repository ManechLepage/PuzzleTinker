@tool
extends Button

@onready var texture_rect = $TextureRect
var current_item: Item
signal clicked(item: Item)

func load_item(item: Item) -> Signal:
	texture_rect.texture = item.icon
	current_item = item
	return clicked

func _on_pressed():
	clicked.emit(current_item)

func clear():
	texture_rect.texture = null
	current_item = null
