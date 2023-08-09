extends Node

var next_level = null

@onready var handling : bool = false

var next_destID : int = 0



# set default level
@onready var current_level = $devisland
# reference fade out animation
@onready var anim = $AnimationPlayer


func _ready() -> void:
	# temporary -- resets the saved level data every time program is run
	clear_save_cache()
	
	current_level.level_changed.connect(self.handle_level_changed)
	
	
	
func handle_level_changed(destination_name: String, destID: int):
	if not handling:
		handling = true
		#print("start handle_level_changed")
		
		next_destID = destID
		#print("next dest ID is", next_destID)

		var check_next_level = load("res://saves/" + destination_name + ".tscn").instantiate()
		print("checked: ", check_next_level)

		if check_next_level.unvisited == true:
			print("level was unvisited, loading brand new copy")
			next_level = load("res://levels/" + destination_name + ".tscn").instantiate()
		else:
			print("level was previously visited, loading the save")
			next_level = load("res://saves/" + destination_name + ".tscn").instantiate() 	
			
		next_level.visible = false
		
		# this generates some errors but it cannot be deferred
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
	var spawnLocs = new_scene.get_tree().get_nodes_in_group("Spawn")
	var spawnLoc
	
	#print(spawnLocs)
	
	for loc in spawnLocs:
		#print(loc.destID)
		if loc.destID == next_destID:
			print("found the right spawn area!")
			spawnLoc = loc
	
	#print(spawnLoc)
	
	var newPlayerLocation = spawnLoc.global_position

	#print(oldPlayer)
	#print(oldPlayerCopy)
	#print(newPlayer)
	#print(newPlayerLocation)
	
	new_scene.remove_child(newPlayer)
	new_scene.add_child.call_deferred(oldPlayerCopy)
	
	var showChildren = new_scene.get_children()
	#print(showChildren)
	
	oldPlayerCopy.global_position = newPlayerLocation

	# end transfer player






# fade transition

func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"fade_in":
			#print("cleanup1")
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





# clear temporary save files (deletes the cached version of each level, 
# temporarily setting this to on so the world resets every time I rerun the program
func clear_save_cache():
	print("clearing save cache..")
	OS.execute("python", ["clearsave.py"])
	

