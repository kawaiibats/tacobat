extends Node2D


signal level_changed(destination)

@export var level_name = "devisland"
@export var unvisited = true


var savePackage:PackedScene
var instancePackage:Node
var saveFile : String = "res://saves/" + level_name + ".tscn"

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



