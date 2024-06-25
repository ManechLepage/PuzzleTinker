extends Control

@onready var name_label = $Name
@onready var description = $Description
@onready var texture_rect = $TextureRect
@onready var craft = $Craft
@onready var inventory = %Inventory

@export var craft_text: PackedScene

var current_blueprint: Blueprint

func load_blueprint(blueprint: Blueprint, is_discovery: bool):
	current_blueprint = blueprint
	visible = true
	name_label.text = blueprint.item.name
	description.text = blueprint.description
	texture_rect.texture = blueprint.icon
	
	for child in craft.get_children():
		if child.name != "Title":
			child.queue_free()
	
	for i in blueprint.craft:
		var text = craft_text.instantiate()
		text.text = "- " + i.item.name + " x" + str(i.quantity)
		craft.add_child(text)
	
	if is_discovery:
		pass


func _on_close_pressed():
	get_tree().get_first_node_in_group("Player").exit_menu()
	visible = false

func _on_button_pressed():
	pass
