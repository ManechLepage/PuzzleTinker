extends CanvasLayer

var hide: bool = false
@onready var inventory = $Inventory
@onready var blueprints = $Blueprints


func _input(event):
	if Input.is_action_just_pressed("Inventory"):
		if !hide:
			var inventory_tween = create_tween()
			inventory_tween.tween_property(inventory, "position", Vector2(inventory.position.x + 150, 0), 0.2).set_ease(Tween.EASE_OUT)
			var blueprints_tween = create_tween()			
			blueprints_tween.tween_property(blueprints, "position", Vector2(blueprints.position.x, blueprints.position.y + 150), 0.2).set_ease(Tween.EASE_OUT)
		else:
			var inventory_tween = create_tween()
			inventory_tween.tween_property(inventory, "position", Vector2(inventory.position.x - 150, 0), 0.2).set_ease(Tween.EASE_OUT)
			var blueprints_tween = create_tween()
			blueprints_tween.tween_property(blueprints, "position", Vector2(blueprints.position.x, blueprints.position.y - 150), 0.2).set_ease(Tween.EASE_OUT)
			
		hide = !hide
