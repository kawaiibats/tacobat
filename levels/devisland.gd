extends Node2D

signal level_changed(destination)

@export var level_name = "devisland"
@export var unvisited = true


var savePackage:PackedScene
var instancePackage:Node
var saveFile : String = "res://saves/" + level_name + ".tscn"




class foragable:
	var rarity = 1
	var stones = 10
	var name = "wheat"
	


func _ready():
	if (unvisited):
		genesis()
	unvisited = false


func play_loaded_sound():
	print("Play Loaded Sound!")
	$LevelLoadedSound.play()

func play_warp_enter_sound():
	print("Play Warp Enter Sound!")
	$WarpAreaEnterSound.play()



func genesis():
	print ("Dev Island Genesis Activating..")
	
	# Spawn 1-8 foragable entities within roughly 30-60 possible locations 
	
	var foragePool = $ForagePool.get_children()
	
	print("Available forage pool:", foragePool)
	
	var entitySpawnZonePool = []
	
	for _i in self.get_children():
		if _i.is_in_group("EntitySpawn") and _i.get_child_count() == 1:
			entitySpawnZonePool.append(_i)
			
	print ("Available entity spawn pool:", entitySpawnZonePool)
	
	
	# roll 1-8 (but with special odds) will add later, for now it always 1
	
	var spawnForageNum = 1
	
	for i in range(spawnForageNum):
		
		# roll a d100 to determine rarity
		
		randi_range(0,100)
		
		
	
	
	
	
	# Spawn 1-4 destructible objects (like bushes, trees)
	







func cleanup():
	#print("cleanup2")
	if $WarpAreaEnterSound.playing:
		#print("cleanup3")
		await $WarpAreaEnterSound.finished
	#print("cleanup4")
	
	for child in get_children():
		if child.has_method("end_animation"):
			child.end_animation()	
	
	savePackage = ScenePacker.create_package(self)
	print("package created")
	
	var error: = ResourceSaver.save(savePackage, saveFile)
	if error != OK:
		push_error("An error occurred while saving the scene to disk.")
	
	queue_free()
	


# WARP ZONES


func _on_warper_warp_area_entered(destination, destID):
	print("game level print by spawn")
	warp(destination, destID)

func _on_warpdevlvl_2_warp_area_entered(destination, destID):
	print("game level print top exit 1")
	warp(destination, destID)
	
func _on_warp_2_devlvl_2_warp_area_entered(destination, destID):
	print("game level print top exit 2")
	warp(destination, destID)
	


func warp(destination, destID):
	play_warp_enter_sound()
	print("emitted level signal")
	emit_signal("level_changed", destination, destID)



