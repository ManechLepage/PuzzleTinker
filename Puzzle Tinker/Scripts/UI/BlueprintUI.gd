@tool
extends Control

@export var update: bool = false
@export var tab_scene: PackedScene
@onready var blueprints_control = $VBoxContainer/Blueprints
@onready var tabs = $VBoxContainer/Blueprints/Tabs
@onready var blueprint_info = %BlueprintInfo

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
	print("Updating tabs...")
	for tab in type_values:
		tabs.get_child(tab).load_tab(tab)

func _on_tab_bar_tab_changed(tab):
	for tab_control in tabs.get_children():
		tab_control.visible = false
	
	tabs.get_child(tab).visible = true

func _on__load_new_blueprint_info(blueprint: Blueprint):
	blueprint_info.load_blueprint(blueprint)
