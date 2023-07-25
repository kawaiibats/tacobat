class_name Resource_Manager extends Node


const STAT_PATH = "res://components/inventory/items/data/stats.json"


var sprites = {
	"apple" : preload( "res://art/item_icon/apple.png" ),
	"brown_mush" : preload( "res://art/item_icon/brown_mush.png" ),
	"red_mush" : preload( "res://art/item_icon/red_mush.png" ),
	"wheat" : preload( "res://art/item_icon/wheat.png" ),
	"golden_berry" : preload( "res://art/item_icon/apple.png" ),
	"jojiberry" : preload( "res://art/item_icon/apple.png" ),
	"speed_trinket" : preload( "res://art/item_icon/speed_trinket.png" )
}



@onready var stat_info = {}



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
	
	var stats = readJSON(STAT_PATH)
	
	print('stats:', stats)
	
	for stat in stats:
		print("STI:", stats[stat])
		
		stat_info[ Game_Enums.STAT[ stat ] ] = stats[stat]
	
	#stat_info = stats
	
	print("stats information dictionary FROM JSON: ", stat_info)



