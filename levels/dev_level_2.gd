#dev_level_2.gd

extends Level



func _init():
	level_name = "dev_level_2"
	saveFile = "res://saves/" + level_name + ".tscn"


# WARP ZONES

func _on_warp_area_warp_area_entered(destination, destID):
	print("dev level 2 warper (#1)")
	warp(destination, destID)

func _on_warp_2_devisland_2_warp_area_entered(destination, destID):
	print("dev level 2 warper (#2)")
	warp(destination, destID)


