extends Control

@onready var item_container = %ItemContainer
@onready var structure_container = %StructureContainer
@export var item_preview_scene: PackedScene

var hide: bool = false

func _on_inventory_update(data: Dictionary):
	for child in item_container.get_children():
		child.queue_free()
	
	for item in data.keys():
		var item_preview = item_preview_scene.instantiate()
		item_container.add_child(item_preview)
		item_preview.load_item(item.name, item.icon, data.get(item))

func _input(event):
	if Input.is_action_just_pressed("Inventory"):
		if !hide:
			var tween = create_tween()
			tween.tween_property(self, "position", Vector2(position.x + 150, 0), 0.2).set_ease(Tween.EASE_OUT)
		else:
			var tween = create_tween()
			tween.tween_property(self, "position", Vector2(position.x - 150, 0), 0.2).set_ease(Tween.EASE_OUT)
		hide = !hide
