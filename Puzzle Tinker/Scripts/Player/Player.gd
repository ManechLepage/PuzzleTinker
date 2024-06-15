class_name Player
extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_jumped: bool = false
var facing_right: bool = true
var tile_map: TileMap
var inventory: Inventory
var current_selected_structure: StructureScene

@export var is_in_menu: State

signal update_structure_menu

@onready var sprite_2d = $Sprite2D
@onready var state_machine = $StateMachine


@export var building_state: State

func _ready():
	tile_map = get_tree().get_first_node_in_group("TileMap")
	inventory = get_tree().get_first_node_in_group("Inventory")
	state_machine.init(self)

func _physics_process(delta):
	state_machine.process_physics(delta)

func _process(delta):
	state_machine.process_frame(delta)

func _unhandled_input(event):
	state_machine.process_inputs(event)

func start_building(structure: Structure):
	building_state.currently_placing = structure
	state_machine.change_state(building_state)

func _on_building_place_block(structure):
	tile_map.place_structure(structure, get_global_mouse_position())

func set_structure_selection(structure: StructureScene):
	current_selected_structure = structure

func clear_structure_selection():
	current_selected_structure = null

func remove_structure_ui():
	if state_machine.current_state == is_in_menu:
		state_machine.current_state.is_idle = true

func _on_building_initialize_placeholder(structure):
	tile_map.create_placeholder(structure)

func remove_placeholder():
	tile_map.clear_placeholder()

func _on_building_place_cable(cable):
	tile_map.create_placeholder(cable)

func _on_building_finish_cable_placing():
	tile_map.finish_cable_placing()
