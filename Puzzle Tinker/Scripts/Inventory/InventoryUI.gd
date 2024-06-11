extends Control

@onready var item_container = %ItemContainer
@onready var structure_container = %StructureContainer
@export var item_preview_scene: PackedScene
@export var structure_preview_scene: PackedScene

var hide: bool = false

func _on_inventory_update(data: Dictionary):
	for child in item_container.get_children():
		child.queue_free()
	for child in structure_container.get_children():
		child.queue_free()
	
	for item in data.keys():
		if item is Structure:
			var item_preview = structure_preview_scene.instantiate()
			structure_container.add_child(item_preview)
			item_preview.load_item(item, item.name, item.icon, data.get(item))
			item_preview.initialize_building_mode.connect(on_initializing_building_mode)
		else:
			var item_preview = item_preview_scene.instantiate()
			item_container.add_child(item_preview)
			item_preview.load_item(item, item.name, item.icon, data.get(item))

func _input(event):
	if Input.is_action_just_pressed("Inventory"):
		if !hide:
			var tween = create_tween()
			tween.tween_property(self, "position", Vector2(position.x + 150, 0), 0.2).set_ease(Tween.EASE_OUT)
		else:
			var tween = create_tween()
			tween.tween_property(self, "position", Vector2(position.x - 150, 0), 0.2).set_ease(Tween.EASE_OUT)
		hide = !hide

func on_initializing_building_mode(structure: Structure):
	get_tree().get_first_node_in_group("Player").start_building(structure)
