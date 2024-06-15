extends Node2D

@export var middle: PackedScene
var is_ready: bool = false

func _ready():
	is_ready = true

func _process(delta):
	if is_ready:
		is_ready = false
		to_ground()

func to_ground():
	var tile_map: TileMap = get_tree().get_first_node_in_group("TileMap")
	var tile_position = tile_map.local_to_map(get_parent().global_position)
	var ground_tiles = tile_map.get_used_cells(0)
	
	for child in get_children():
		child.queue_free()
	
	var is_on_ground: bool = false
	var last_position: Vector2i = tile_position
	var positions: Array[Vector2i]
	
	while not is_on_ground:
		positions.append(last_position)
		last_position -= Vector2i(0, -1)
		if last_position in ground_tiles:
			is_on_ground = true
	
	for pos in positions:
		if pos != tile_position:
			var part = middle.instantiate()
			add_child(part)
			part.global_position = get_tree().get_first_node_in_group("TileMap").map_to_local(pos)
