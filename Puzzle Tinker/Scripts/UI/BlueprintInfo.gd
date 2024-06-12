extends Control

@onready var name_label = $Name
@onready var description = $Description
@onready var texture_rect = $TextureRect
@onready var build = $Button/Label
@onready var craft = $Craft
@onready var inventory = %Inventory
@onready var build_button = $Button

@export var craft_text: PackedScene

var current_blueprint: Blueprint

func load_blueprint(blueprint: Blueprint):
	current_blueprint = blueprint
	visible = true
	name_label.text = blueprint.item.name
	description.text = blueprint.description
	texture_rect.texture = blueprint.icon
	build.text = "Build x" + str(blueprint.quantity)
	
	for child in craft.get_children():
		if child.name != "Title":
			child.queue_free()
	
	for i in blueprint.craft:
		var text = craft_text.instantiate()
		text.text = "- " + i.item.name + " x" + str(i.quantity)
		craft.add_child(text)
	
	build_button.disabled = !inventory.can_build(blueprint)

func _on_close_pressed():
	visible = false

func _on_button_pressed():
	if inventory.can_build(current_blueprint):
		for i in current_blueprint.craft:
			inventory.add_item(i.item, -i.quantity)
		inventory.add_item(current_blueprint.item, current_blueprint.quantity)
	visible = false
