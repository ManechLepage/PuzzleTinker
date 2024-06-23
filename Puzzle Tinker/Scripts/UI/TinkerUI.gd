extends Control

@onready var material_selection = $MaterialSelection
@export var item_button: PackedScene

var inventory: Inventory
var tinkering_recipes: TinkeringRecipes
var current_selection = null
var current_recipe: TinkerCraft
var player: Player


@onready var top = $Default/Top
@onready var base = $Default/Base
@onready var build = $Default/Build
@onready var output = $Default/Output

func _ready():
	inventory = get_tree().get_first_node_in_group("Inventory")
	tinkering_recipes = get_tree().get_first_node_in_group("TinkeringRecipes")
	player = get_tree().get_first_node_in_group("Player")

func _on_pressed(is_top):
	if current_selection == is_top and material_selection.visible:
		material_selection.visible = false
	else:
		material_selection.visible = true
		var target_type = TinkerType.type.Base
		if is_top:
			target_type = TinkerType.type.Top
		for child in material_selection.get_child(1).get_children():
			if child.name != "Clear":
				child.queue_free()
		for item in inventory.data.keys():
			if item.tinker_type == target_type:
				var button: Button = item_button.instantiate()
				material_selection.get_child(1).add_child(button)
				material_selection.get_child(1).move_child(button, 0)
				button.load_item(item).connect(selected_item)
	current_selection = is_top

func selected_item(item: Item):
	if current_selection:
		top.load_item(item)
	else:
		base.load_item(item)
	material_selection.visible = false
	current_selection = null
	update_output()

func update_output():
	var can_craft = false
	for recipe in tinkering_recipes.data:
		if recipe.base == base.current_item:
			if recipe.top == top.current_item:
				can_craft = true
				output.texture = recipe.output.icon
				current_recipe = recipe
	
	build.disabled = !can_craft

func _on_build_pressed():
	top.clear()
	base.clear()
	output.texture = null
	output.get_child(0).text = ""
	
	inventory.add_item(current_recipe.base, -1)
	inventory.add_item(current_recipe.top, -1)
	inventory.add_item(current_recipe.output, 1)
	
	player.remove_structure_ui()


func _on_clear_pressed():
	if current_selection:
		top.clear()
	else:
		base.clear()
		
	material_selection.visible = false
	update_output()
