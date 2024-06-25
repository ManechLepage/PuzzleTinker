@tool
extends Control

@export var update: bool = false
@export var tab_scene: PackedScene
@onready var blueprints_control = $VBoxContainer/Blueprints
@onready var tabs = $VBoxContainer/Blueprints/Tabs
@onready var blueprint_info = %BlueprintInfo
@onready var inventory = %Inventory

func _ready():
	Update()
	_on_tab_bar_tab_changed(0)

func _process(delta):
	if update:
		update = false
		Update()

func Update():
	var blueprint_manager = %Blueprints
	blueprint_manager.load_blueprints()
	
	var type_values = BlueprintTypes.BlueprintTypes.values()
	for tab in type_values:
		tabs.get_child(tab).load_tab(tab)

func _on_tab_bar_tab_changed(tab):
	for tab_control in tabs.get_children():
		tab_control.visible = false
	
	tabs.get_child(tab).load_tab(tab)
	tabs.get_child(tab).visible = true

func _on_build_blueprint(blueprint):
	if inventory.can_build(blueprint):
		for i in blueprint.craft:
			inventory.add_item(i.item, -i.quantity)
		inventory.add_item(blueprint.item, blueprint.quantity)
