extends Node2D
@onready var background_sprite = $Background
@onready var temp_background = $TempBackground

func load_background(background: Background, _position: Vector2):
	transition()
	background_sprite.position = _position
	background_sprite.texture = background.main_detail

func transition():
	temp_background.position = background_sprite.position
	temp_background.texture = background_sprite.texture
