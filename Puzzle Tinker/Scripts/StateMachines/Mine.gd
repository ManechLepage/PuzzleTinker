extends State

@export var idle: State
@onready var timer = $Timer

var currently_mining: Vector2i
var mining_data: MiningMaterial
var mined: bool = false

@export var copper: Item

func enter():
	super()
	var minerals: Array[Vector2i] 
	for tile in parent.tile_map.get_surrounding_cells(parent.tile_map.local_to_map(parent.position)):
		var tile_data = parent.tile_map.get_cell_tile_data(0, tile)
		if tile_data:
			if tile_data.get_custom_data("mineral") > -1:
				minerals.append(tile)
	
	if len(minerals) > 0:
		currently_mining = minerals[0]
		var mining_id = parent.tile_map.get_cell_tile_data(0, minerals[0]).get_custom_data("mineral")
		mining_data = parent.materials.get_material_from_id(mining_id)
		timer.start(mining_data.mining_time)
	else:
		mined = true

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
	parent.inventory.add_item(mining_data.item, mining_data.quantity)
	mined = true
	parent.tile_map.erase_cell(0, currently_mining)
