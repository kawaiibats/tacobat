extends Node2D


signal level_changed(destination)

@export var level_name = "devisland"




func genesis():
	print ("Dev Island Genesis Activating..")












# WARP ZONES


func _on_warper_warp_area_entered(destination):
	print("game level print by spawn")
	emit_signal("level_changed", destination)


func _on_warpdevlvl_2_warp_area_entered(destination):
	print("game level print top exit 1")
	emit_signal("level_changed", destination)
	
	
func _on_warp_2_devlvl_2_warp_area_entered(destination):
	print("game level print top exit 2")
	emit_signal("level_changed", destination)


func _on_warp_area_warp_area_entered(destination):
	print("game level print by spawn, alternate")
	emit_signal("level_changed", destination)
