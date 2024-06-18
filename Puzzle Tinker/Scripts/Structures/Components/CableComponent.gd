@tool
extends Node2D

@onready var start = $"../Start"
@onready var last = $"../Last"

@export_category("Colors")
@export var default_color: Color
@export var error_color: Color

@export_category("Physics Settings")
@export var max_cable_size: float = 40.0
@export var ropeLength: float = 30
@export var constrain: float = 1
@export var gravity: Vector2 = Vector2(0,9.8)
@export var dampening: float = 0.9
@export var startPin: bool = true
@export var endPin: bool = true

@export_category("Power Settings")
@export var transport_time: float

@onready var line_2d = $"../Line2D"
@onready var path_2d = $"../Path2D"
@onready var timer = $Timer

var pos: Array
var posPrev: Array
var pointCount: int
var can_be_placed: int

var tile_map: TileMap

var is_in_range: bool = true

signal end_powered

func _ready():
	line_2d.default_color = default_color
	pointCount = get_pointCount(ropeLength)
	resize_arrays()
	init_position()
	tile_map = get_tree().get_first_node_in_group("TileMap")

func power():
	timer.start(transport_time)

func set_to_default_color():
	line_2d.default_color = default_color

func set_to_error_color():
	line_2d.default_color = error_color

func get_pointCount(distance: float):
	return int(ceil(distance / constrain))

func resize_arrays():
	pos.resize(pointCount)
	posPrev.resize(pointCount)

func init_position():
	for i in range(pointCount):
		pos[i] = position + Vector2(constrain *i, 0)
		posPrev[i] = position + Vector2(constrain *i, 0)
	position = Vector2.ZERO
	start.position = position
	last.position = position

func _process(delta):
	set_start(start.position)
	set_last(last.position)
	
	update_points(delta)
	update_constrain()
	line_2d.points = pos
	path_2d.curve.clear_points()
	
	if not Engine.is_editor_hint():
		if get_parent().editing:
			if start.global_position.distance_to(get_global_mouse_position()) > max_cable_size:
				is_in_range = false
			else:
				is_in_range = true

func set_start(p:Vector2):
	pos[0] = p
	posPrev[0] = p

func set_last(p:Vector2):
	pos[pointCount-1] = p
	posPrev[pointCount-1] = p

func update_points(delta):
	for i in range (pointCount):
		if (i!=0 && i!=pointCount-1) || (i==0 && !startPin) || (i==pointCount-1 && !endPin):
			var velocity = (pos[i] -posPrev[i]) * dampening
			posPrev[i] = pos[i]
			pos[i] += velocity + (gravity * delta)

func update_constrain():
	for i in range(pointCount):
		if i == pointCount-1:
			return
		var distance = pos[i].distance_to(pos[i+1])
		var difference = constrain - distance
		var percent = difference / distance
		var vec2 = pos[i+1] - pos[i]
		
		if i == 0:
			if startPin:
				pos[i+1] += vec2 * percent
			else:
				pos[i] -= vec2 * (percent/2)
				pos[i+1] += vec2 * (percent/2)
		elif i == pointCount-1:
			pass
		else:
			if i+1 == pointCount-1 && endPin:
				pos[i] -= vec2 * percent
			else:
				pos[i] -= vec2 * (percent/2)
				pos[i+1] += vec2 * (percent/2)

func _on_timer_timeout():
	end_powered.emit()
