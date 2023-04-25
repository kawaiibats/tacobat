extends Node2D


signal level_changed(destination)

@export var level_name = "devisland"


func play_loaded_sound():
	print("Play Loaded Sound!")
	$LevelLoadedSound.play()

func play_warp_enter_sound():
	print("Play Warp Enter Sound!")
	$WarpAreaEnterSound.play()



func genesis():
	print ("Dev Island Genesis Activating..")



func cleanup():
	print("cleanup2")
	if $WarpAreaEnterSound.playing:
		print("cleanup3")
		await $WarpAreaEnterSound.finished
	print("cleanup4")
	queue_free()



# WARP ZONES


func _on_warper_warp_area_entered(destination):
	print("game level print by spawn")
	warp(destination)

func _on_warpdevlvl_2_warp_area_entered(destination):
	print("game level print top exit 1")
	warp(destination)
	
func _on_warp_2_devlvl_2_warp_area_entered(destination):
	print("game level print top exit 2")
	warp(destination)
	


func warp(destination):
	play_warp_enter_sound()
	emit_signal("level_changed", destination)



