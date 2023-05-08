# devisland.gd

extends Node2D

signal level_changed(destination)

@export var level_name = "devisland"
@export var unvisited = true





var savePackage:PackedScene
var instancePackage:Node
var saveFile : String = "res://saves/" + level_name + ".tscn"



var print_debug = false


func _ready():
	if (unvisited):
		genesis()
	unvisited = false

	# fix foragys position
	for child in get_children():
		if child.has_method("reset_childs_position"):
			child.reset_childs_position()
	





















# SFX

func play_loaded_sound():
	print("Play Loaded Sound!")
	$LevelLoadedSound.play()

func play_warp_enter_sound():
	print("Play Warp Enter Sound!")
	$WarpAreaEnterSound.play()



# GENESIS required functions # #################################

func choose_random(rand_list):
	if rand_list.size() != 0:
		return rand_list[randi() % rand_list.size()]

func place_foragy(foragyPool, zonePool):
	var selectedForagy = choose_random(foragyPool)
	var selectedForagyInstance = selectedForagy.duplicate()
	var selectedZone = choose_random(zonePool)
	
	zonePool.erase(selectedZone)
	
	print("Foragy picked:", selectedForagy)
	print("Zone picked:", selectedZone)
	
	#set foragy as visible
	selectedForagyInstance.visible = true
	selectedZone.add_child(selectedForagyInstance)
	print("POSITION OF THIS FORAGY:", selectedForagyInstance.position)
	#fix foragy position to be at 0 0 
	var zed = Vector2(0,0)
	selectedForagyInstance.position = zed
	

# GENESIS - plays when a level is visited for the very first time.
func genesis():
	print ("Dev Island Genesis Activating..")
	
	# Spawn 1-8 foragable entities within roughly 30-60 possible locations 
	
	# gets the level's foragables from the pool node
	var foragePool = $ForagePool.get_children()
	if (print_debug): print("Available forage pool:", foragePool)
	
	
	# gets the empty entity spawn zones that can be picked to spawn on
	var entitySpawnZonePool = []

	for _i in self.get_children():
		if _i.is_in_group("EntitySpawn") and _i.get_child_count() == 2:
			entitySpawnZonePool.append(_i)
			
	if (print_debug): print ("Available entity spawn pool:", entitySpawnZonePool)
	
	
	# roll 1-8 (but with special odds) to determine how many foragys will spawn
	
	var numSpawnsRoll = randi_range(1,100)
	var spawnForageNum = 0
	
	if numSpawnsRoll >= 1 and numSpawnsRoll <= 10:
		spawnForageNum = 1
	elif numSpawnsRoll >= 11 and numSpawnsRoll <= 30:
		spawnForageNum = 2
	elif numSpawnsRoll >= 31 and numSpawnsRoll <= 60:
		spawnForageNum = 3
	elif numSpawnsRoll >= 61 and numSpawnsRoll <= 70:
		spawnForageNum = 4
	elif numSpawnsRoll >= 71 and numSpawnsRoll <= 80:
		spawnForageNum = 5
	elif numSpawnsRoll >= 81 and numSpawnsRoll <= 90:
		spawnForageNum = 6
	elif numSpawnsRoll >= 90 and numSpawnsRoll <= 99:
		spawnForageNum = 7
	else:
		spawnForageNum = 8
	
	print("Spawning ", spawnForageNum, " foragys!")
	
	for i in range(spawnForageNum):
		
		# roll a d100 to determine rarity
		
		var rolling = true
		var rarityRoll = randi_range(1,100)
		
		print("roll:", rarityRoll)
		
		# Select the foragy that will be picked and spawn it 
		while (rolling):
		
			if rarityRoll >= 1 and rarityRoll <= 65:
				print("common roll")
			
				var commonPool = []
			
				for foragy in foragePool:
					if foragy.getRarity() == 1:
						for j in foragy.getStones():
							print("appending ", foragy, " to common pool")
							commonPool.append(foragy)
			
				if commonPool.is_empty():
					print("There are no commons! Nothing will spawn.")
					rolling = false
				else:
					place_foragy(commonPool, entitySpawnZonePool)

					rolling = false
			
			elif rarityRoll >= 66 and rarityRoll <= 85:
				print("uncommon roll")
			
				var uncommonPool = []
			
				for foragy in foragePool:
					if foragy.getRarity() == 2:
						for j in foragy.getStones():
							print("appending ", foragy, " to uncommon pool")
							uncommonPool.append(foragy)
			
				if uncommonPool.is_empty():
					print("There are no uncommons! Switching over to common.")
					rarityRoll = 1
				else:
					place_foragy(uncommonPool, entitySpawnZonePool)
					
					rolling = false
			
			elif rarityRoll >= 86 and rarityRoll <= 95:
				print("rare roll")
				
				var rarePool = []
			
				for foragy in foragePool:
					if foragy.getRarity() == 3:
						for j in foragy.getStones():
							print("appending ", foragy, " to rare pool")
							rarePool.append(foragy)
			
				if rarePool.is_empty():
					print("There are no rares! Switching over to uncommon.")
					rarityRoll = 66
				else:
					place_foragy(rarePool, entitySpawnZonePool)
					
					rolling = false
		
			elif rarityRoll >= 96 and rarityRoll <= 99:
				print("exceptional roll")

				var exceptPool = []
			
				for foragy in foragePool:
					if foragy.getRarity() == 4:
						for j in foragy.getStones():
							print("appending ", foragy, " to except pool")
							exceptPool.append(foragy)
			
				if exceptPool.is_empty():
					print("There are no excepts! Switching over to rare.")
					rarityRoll = 86
				else:
					place_foragy(exceptPool, entitySpawnZonePool)
					
					rolling = false
			
			elif rarityRoll == 100:
				print("exotic roll")
	
				var exoticPool = []
			
				for foragy in foragePool:
					for j in foragy.getStones():
						if foragy.getRarity() == 5:
							print("appending ", foragy, " to exotic pool")
							exoticPool.append(foragy)
			
				if exoticPool.is_empty():
					print("There are no exotics! Switching over to exceptional.")
					rarityRoll = 96
				else:
					place_foragy(exoticPool, entitySpawnZonePool)
					
					rolling = false




	# Spawn 1-4 destructible objects (like bushes, trees)
	
	# ~ 


# TIMEMARCH - activates in visited levels at the beginning morning (excluding first morning)
# Essentially is a weaker genesis that replenishes forages over time
func timemarch():
	pass




# CLEANUP - activates when the level is exited
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
	
func _on_warp_2_taco_warp_area_entered(destination, destID):
	print("game level print taco world exit")
	warp(destination, destID)
	
# warp function
func warp(destination, destID):
	play_warp_enter_sound()
	print("emitted level signal")
	emit_signal("level_changed", destination, destID)





