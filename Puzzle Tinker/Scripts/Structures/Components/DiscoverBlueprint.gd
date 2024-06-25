extends Node

var blueprints: Node
var blueprint: Blueprint
var tile_map: TileMap

func _ready():
	blueprints = get_tree().get_first_node_in_group("Blueprints")
	var discovery_manager = get_tree().get_first_node_in_group("Discovery")
	tile_map = get_tree().get_first_node_in_group("TileMap")
	blueprint = discovery_manager.get_blueprint(tile_map.local_to_map(get_parent().global_position))

func _on_button_enabled():
	blueprints.learn_blueprint(blueprint)


func _on_button_disabled():
	tile_map.erase_cell(1, tile_map.local_to_map(get_parent().global_position))
