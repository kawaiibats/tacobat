# devisland.gd

extends Level



func _init():
	level_name = "devisland"
	saveFile = "res://saves/" + level_name + ".tscn"
	

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
	

