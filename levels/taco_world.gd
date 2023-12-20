# taco_world.gd

extends Level



func _init():
	level_name = "taco_world"
	saveFile = "res://saves/" + level_name + ".tscn"


# WARP ZONES

func _on_warp_area_warp_area_entered(destination, destID):
	print("taco world print by spawn")
	warp(destination, destID)








