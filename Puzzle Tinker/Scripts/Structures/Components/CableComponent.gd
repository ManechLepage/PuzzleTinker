extends Node2D

var piece_length: float = 4.0
var cable_parts: Array
var cable_close_tolerance = 4.0
var cable_points: Array

@onready var start_anchor = $"../StartAnchor"
@onready var end_anchor = $"../EndAnchor"

@onready var start_joint: PinJoint2D = start_anchor.get_node("C/J")
@onready var end_joint: PinJoint2D = end_anchor.get_node("C/J")

@export var cable_piece: PackedScene

func _process(delta):
	get_points()
	queue_redraw()

func spawn_cable(starting_position: Vector2, end_position: Vector2):
	start_anchor.global_position = starting_position
	end_anchor.global_position = end_position
	
	var distance = starting_position.distance_to(end_position)
	var segment_amount = round(distance / piece_length)
	var spawn_angle = (end_position - starting_position).angle() - PI/2
	
	create_cable(segment_amount, start_anchor, end_position, spawn_angle)

func create_cable(segment_amount, parent, end_position, spawn_angle):
	for i in segment_amount:
		parent = add_piece(parent, i, spawn_angle)
		parent.name = str(i)
		cable_parts.append(parent)
		
		var joint_position = parent.get_node("C/J").global_position
		if joint_position.distance_to(end_position) < cable_close_tolerance:
			break
	
	end_joint.node_a = end_anchor.get_path()
	end_joint.node_a = cable_parts[-1].get_path()

func add_piece(parent, id, spawn_angle):
	var joint: PinJoint2D = parent.get_node("C/J")
	var piece: Object = cable_piece.instantiate()
	piece.global_position = joint.global_position
	piece.rotation = spawn_angle
	piece.parent = self
	piece.id = id
	add_child(piece)
	joint.node_a = parent.get_path()
	joint.node_b = piece.get_path()
	
	return piece

func get_points():
	cable_points.clear()
	
	cable_points.append(start_joint.global_position)
	for c in cable_parts:
		cable_points.append(c.global_position)
	cable_points.append(end_joint.global_position)

func _draw():
	draw_polyline(cable_points, Color.AQUAMARINE)
