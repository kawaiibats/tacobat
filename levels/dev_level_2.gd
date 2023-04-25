extends Node2D


signal level_changed(destination)

@export var level_name = "devlevel2"


func play_loaded_sound() -> void:
	$LevelLoadedSound.play()



	
func genesis():
	print ("Dev Level Two Genesis Activating..")


func cleanup():
	print("cleanup2")
	if $WarpAreaEnterSound.playing:
		print("cleanup3")
		await $WarpAreaEnterSound.finished
	print("cleanup4")
	queue_free()




func _on_warp_area_warp_area_entered(destination):
	print("dev level 2 print")
	warp(destination)


func warp(destination):
	$WarpAreaEnterSound.play()
	emit_signal("level_changed", destination)
