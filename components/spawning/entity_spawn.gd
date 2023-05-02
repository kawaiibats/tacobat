extends Area2D
class_name entitySpawnZone

@export var entitySpawnID = 0

func reset_childs_position():
	for child in get_children():
		if child.has_method("resetPosition"):
			child.resetPosition()

func add_to_list():
	pass
