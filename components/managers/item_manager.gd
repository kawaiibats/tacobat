extends Node


const ITEM_PATH = "res://components/inventory/items/data/items.json"


@onready var items = { }


@onready var placeholders = {
	Game_Enums.ITEM_TYPE.EQUIPMENT_HEAD : load( "res://art/calame/placeholder_head.png" ),
	Game_Enums.ITEM_TYPE.EQUIPMENT_TORSO : load( "res://art/calame/placeholder_torso.png" ),
	Game_Enums.ITEM_TYPE.EQUIPMENT_BOTTOM : load( "res://art/calame/placeholder_bottom.png" ),
	Game_Enums.ITEM_TYPE.EQUIPMENT_FEET : load( "res://art/calame/placeholder_feet.png" ),
	Game_Enums.ITEM_TYPE.EQUIPMENT_TRINKET : load( "res://art/calame/placeholder_trinket.png" ),
	Game_Enums.ITEM_TYPE.SEED : load ( "res://art/calame/placeholder_seeds.png" )
}





# Item Manager functions























# LEGACY ITEM MANAGER FUNCTIONS
# func get_itemIDs(path):
#	var dir = DirAccess.open(path)
#	if dir:
#		dir.list_dir_begin()
#		var file_name = dir.get_next()
#		while file_name != "":
#			if dir.current_is_dir():
#				print("Found directory: " + file_name)
#			else:
#				print("Found file: " + file_name)
#				var edit_file_name = file_name.trim_suffix(".tscn")
#				# itemIDs.append(edit_file_name) outdated
#			file_name = dir.get_next()
#	else:
#		print("An error occurred when trying to access the path.")





# Global functions

func get_item( id : String ):
	return Item.new( id, items[ id ] )

func get_placeholder( id ):
	return placeholders[ id ]


# JSON parsing function
# Credit to u/condekua https://www.reddit.com/r/godot/comments/116nd15/tutorial_read_a_json_file_in_godot_4_rc2/
func readJSON(json_file_path):
	var file = FileAccess.open(json_file_path, FileAccess.READ)
	var content = file.get_as_text()
	var json = JSON.new()
	var finish = json.parse_string(content)
	return finish


# Main script

func _ready():
	
	items = readJSON(ITEM_PATH)
	
	print("items dictionary FROM JSON: ", items)









