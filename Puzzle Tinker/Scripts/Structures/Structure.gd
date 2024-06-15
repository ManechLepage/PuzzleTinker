class_name StructureScene
extends Node2D

signal enabled
signal disabled

@export var placeholder: bool = true
@export var connect_to_ground: bool = false
@export var has_power: bool = false

func enable():
	enabled.emit()

func disable():
	disabled.emit()
