extends Node

var is_left: bool = true

signal update_to_left
signal update_to_right

func to_right():
	if is_left:
		update_to_right.emit()
	is_left = false
	get_parent().scale.y = -1

func to_left():
	if not is_left:
		update_to_left.emit()
	is_left = true
	get_parent().scale.y = 1
