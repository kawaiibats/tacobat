extends Node

#set default level
@onready var current_level = $lvl0




func _ready() -> void:
	current_level.level_changed.connect(self.handle_level_changed)
	
	
func handle_level_changed(destination: String):
	print("start handle_level_changed")
	
	var next_level
	var lvl_name

	next_level = load("res://levels/" + destination + ".tscn").instantiate()
	add_child(next_level)
	next_level.level_changed.connect(self.handle_level_changed)
	current_level.queue_free()
	current_level = next_level



