extends State

@export var idle: State
@onready var timer = $Timer

var currently_mining: Vector2i
var mined: bool = false

@export var copper: Item

func enter():
	super()
	timer.start()
	var minerals: Array[Vector2i] 
	for tile in parent.tile_map.get_surrounding_cells(parent.tile_map.local_to_map(parent.position)):
		var tile_data = parent.tile_map.get_cell_tile_data(0, tile)
		if tile_data:
			if tile_data.get_custom_data("mineral"):
				minerals.append(tile)
	
	if len(minerals) == 1:
		currently_mining = minerals[0]
	else:
		currently_mining = minerals[0]

func process_inputs(event):
	if Input.is_action_pressed("Left Click"):
		return null
	return idle

func process_frames(delta):
	if mined:
		mined = false
		return idle
	return null

func _on_timer_timeout():
	var tile_data = parent.tile_map.get_cell_tile_data(0, currently_mining)
	parent.inventory.add_item(tile_data.get_custom_data("resource"), 1)
	mined = true
	parent.tile_map.erase_cell(0, currently_mining)
