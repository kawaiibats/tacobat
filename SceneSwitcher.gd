extends Node

var next_level = null
var handling : bool = false



# set default level
@onready var current_level = $devisland
# reference fade out animation
@onready var anim = $AnimationPlayer


func _ready() -> void:
	current_level.level_changed.connect(self.handle_level_changed)
	
	
	
func handle_level_changed(destination_name: String, destPos: int):
	if not handling:
		handling = true
		print("start handle_level_changed")

		var check_next_level = load("res://saves/" + destination_name + ".tscn").instantiate()

		if check_next_level.unvisited == true:
			print("level was unvisited, loading brand new copy")
			next_level = load("res://levels/" + destination_name + ".tscn").instantiate()
		else:
			print("level was previously visited, loading the save")
			next_level = load("res://saves/" + destination_name + ".tscn").instantiate() 	
			
		next_level.visible = false
		add_child(next_level)
		anim.play("fade_in")
		next_level.level_changed.connect(self.handle_level_changed)
		transfer_data(current_level, next_level)

		

func transfer_data(old_scene, new_scene):
	
	# # # # # # # # # # # # # # # # # #
	#
	# TRANSFER THE PLAYER !! 
	# 
	# # # # # # # # # # # # # # # # #
	
	var oldPlayer = old_scene.get_node("PlayerCat")
	var oldPlayerCopy = oldPlayer.duplicate()
	var newPlayer = new_scene.get_node("PlayerCat")
	var spawnLoc = new_scene.get_node("Player Spawn Zone")
	var newPlayerLocation = spawnLoc.global_position

	print(oldPlayer)
	print(oldPlayerCopy)
	print(newPlayer)
	print(newPlayerLocation)
	
	new_scene.remove_child(newPlayer)
	new_scene.add_child(oldPlayerCopy)
	
	var showChildren = new_scene.get_children()
	print(showChildren)
	
	oldPlayerCopy.global_position = newPlayerLocation

	# end transfer player



func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"fade_in":
			print("cleanup1")
			current_level.cleanup()
			current_level = next_level
			current_level.visible = true
			next_level = null
			anim.play("fade_out")
		"fade_out":
			print("reset transition cooldown")
			current_level.play_loaded_sound()
			current_level.get_node("PlayerCat").warping = false
			handling = false






