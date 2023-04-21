extends Node2D


signal level_changed(destination)

@export var level_name = "devlevel2"





	
	
	
	
func genesis():
	print ("Dev Level Two Genesis Activating..")



func _on_warp_area_warp_area_entered(destination):
	print("dev level 2 print")
	emit_signal("level_changed", destination)
