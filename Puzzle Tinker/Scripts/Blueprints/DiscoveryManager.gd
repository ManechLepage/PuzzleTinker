extends Node

@export var discoveries: Array[Discovery]

func get_blueprint(position: Vector2i):
	for discovery in discoveries:
		if discovery.position == position:
			return discovery.blueprint
	return null
