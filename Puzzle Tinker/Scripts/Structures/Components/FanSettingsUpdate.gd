extends Node

@onready var wind_component = $"../../WindComponent"

func update_fan(strength: int):
	wind_component.scale.y = strength + 1
