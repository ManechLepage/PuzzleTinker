extends Node

func _on_area_2d_mouse_entered():
	get_tree().get_first_node_in_group("Player").set_structure_selection(get_parent())

func _on_area_2d_mouse_exited():
	get_tree().get_first_node_in_group("Player").clear_structure_selection()
