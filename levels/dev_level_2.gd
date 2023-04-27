extends Node2D


signal level_changed(destination)

@export var level_name = "dev_level_2"
@export var unvisited = true


var savePackage:PackedScene
var instancePackage:Node
var saveFile : String = "res://saves/" + level_name + ".tscn"

func _ready():
	unvisited = false


func play_loaded_sound() -> void:
	$LevelLoadedSound.play()

func play_warp_enter_sound():
	print("Play Warp Enter Sound!")
	$WarpAreaEnterSound.play()

	
func genesis():
	print ("Dev Level Two Genesis Activating..")


func cleanup():
	print("cleanup2")
	if $WarpAreaEnterSound.playing:
		print("cleanup3")
		await $WarpAreaEnterSound.finished
	print("cleanup4")
	
	# get_tree().paused = true
	
	savePackage = ScenePacker.create_package(self)
	print("package created")
	
	#instancePackage = savePackage.instantiate()
	#print("package instanced")
	
	var error: = ResourceSaver.save(savePackage, saveFile)
	if error != OK:
		push_error("An error occurred while saving the scene to disk.")
	
	queue_free()




func _on_warp_area_warp_area_entered(destination, destID):
	print("dev level 2 print (#1)")
	warp(destination, destID)

func _on_warp_2_devisland_2_warp_area_entered(destination, destID):
	print("dev level 2 print (#2)")
	warp(destination, destID)




func warp(destination, destID):
	play_warp_enter_sound()
	print("emitted level signal")
	emit_signal("level_changed", destination, destID)



