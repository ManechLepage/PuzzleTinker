class_name Player
extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_jumped: bool = false
var facing_right: bool = true
var tile_map: TileMap
var inventory: Inventory
var cable_manager: CableManager
var current_selected_structure: StructureScene
var materials: Materials
var camera_manager: CameraManager


signal update_structure_menu

@onready var sprite = $Sprite2D
@onready var state_machine = $StateMachine

@onready var ground_impact_particles = $Particles/GroundImpact

@export var building_state: State
@export var falling_state: State
@export var idle_state: State
@export var is_in_menu: State

func _ready():
	tile_map = get_tree().get_first_node_in_group("TileMap")
	inventory = get_tree().get_first_node_in_group("Inventory")
	cable_manager = get_tree().get_first_node_in_group("CableManager")
	materials = get_tree().get_first_node_in_group("Materials")
	camera_manager = get_tree().get_first_node_in_group("Camera")
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
	cable_manager.place_cable()

func _on_building_finish_cable_placing():
	cable_manager.finish_cable_placing()

func launch(strength):
	velocity += strength
	falling_state.can_control = false
	state_machine.change_state(falling_state)

func exit_menu():
	state_machine.change_state(idle_state)
