extends Node


@onready var itemIDs = [ ]
# "red_mush", "brown_mush"



@onready var items = { }
# dictionary "red_mush" : load( "res://components/inventory/items/data/red_mush.tscn" )
# 


@onready var placeholders = {
	Game_Enums.ITEM_TYPE.EQUIPMENT_HEAD : load( "res://art/calame/placeholder_head.png" ),
	Game_Enums.ITEM_TYPE.EQUIPMENT_TORSO : load( "res://art/calame/placeholder_torso.png" ),
	Game_Enums.ITEM_TYPE.EQUIPMENT_BOTTOM : load( "res://art/calame/placeholder_bottom.png" ),
	Game_Enums.ITEM_TYPE.EQUIPMENT_FEET : load( "res://art/calame/placeholder_feet.png" ),
	Game_Enums.ITEM_TYPE.EQUIPMENT_TRINKET : load( "res://art/calame/placeholder_trinket.png" ),
	Game_Enums.ITEM_TYPE.SEED : load ( "res://art/calame/placeholder_seeds.png" )
}



# Item Manager functions

func get_itemIDs(path):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				print("Found file: " + file_name)
				var edit_file_name = file_name.trim_suffix(".tscn")
				itemIDs.append(edit_file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")





# Global functions

func get_item( id : String ):
	return items[ id ].instantiate()

func get_placeholder( id ):
	return placeholders[ id ]









# Main script

func _ready():
	
	get_itemIDs("res://components/inventory/items/data/")
	print("itemIDs is: ", itemIDs)
	
	for item in itemIDs:
		
		items[item] = load( "res://components/inventory/items/data/" + item + ".tscn" )

	print("items dictionary: ", items)









