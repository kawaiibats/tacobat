class_name Item_Info extends NinePatchRect


# "Red Mushroom" - ITEM NAME
@export var display_name_path: NodePath
@onready var display_name = get_node( display_name_path ) 


# "Common" + " " + "Foragy" -- ITEM RARITY (if there is one) + ITEM TYPE
# Coloured depending on the rarity
@export var tagline_path: NodePath
@onready var tagline = get_node( tagline_path )



@export var lore_path: NodePath
@onready var lore = get_node( lore_path )



@export var stat_path: NodePath
@onready var stat_display = get_node( stat_path )





func display( slot : Inventory_Slot ):
	self.global_position = slot.size + slot.global_position
	
	# SET DISPLAY NAME
	display_name.text = slot.item.item_name
	
	
	
	
	# SET DISPLAY TAGLINE (RARITY + TYPE)
	
	var tagText = ""
	
	# CHECK FOR RARITY, DISPLAY IT, CHANGE COLOUR
	match slot.item.rarity:
		0:
			tagline.label_settings.font_color = Color(0.67,0.31,0.41)
			
		1 : 
			tagText += "Common "
			tagline.label_settings.font_color = Color.FOREST_GREEN
			
		2 : 
			tagText += "Uncommon "
			tagline.label_settings.font_color = Color.AQUAMARINE
			
		3 : 
			tagText += "Rare "
			tagline.label_settings.font_color = Color.DARK_SLATE_BLUE
		
		4 : 
			if slot.item.type == Game_Enums.ITEM_TYPE.FORAGY:
				tagText += "Elusive "
			elif slot.item.type == Game_Enums.ITEM_TYPE.CROP:
				tagText += "Superior "	
			elif slot.item.type == Game_Enums.ITEM_TYPE.SEED:
				tagText += "Mystical "
			elif slot.item.type == Game_Enums.ITEM_TYPE.RESOURCE:
				tagText += "Pristine "	
			else:
				tagText += "Very Rare "
			
			
			
			tagline.label_settings.font_color = Color.VIOLET
		
		5 : 
			if slot.item.type == Game_Enums.ITEM_TYPE.FORAGY:
				tagText += "Exotic "
			elif slot.item.type == Game_Enums.ITEM_TYPE.CROP:
				tagText += "Extraordinary "	
			elif slot.item.type == Game_Enums.ITEM_TYPE.SEED:
				tagText += "Exquisite "	
			elif slot.item.type == Game_Enums.ITEM_TYPE.RESOURCE:
				tagText += "Perfect "	
			else:
				tagText += "Exceptional "
				
			tagline.label_settings.font_color = Color.GOLDENROD
			
	
	
	# ADD TYPE AND DISPLAY TAGLINE
	match slot.item.type:
		0 :
			if slot.item.family == "":
				tagText += "Foragable"
			else:
				tagText += slot.item.family
		1 :
			if slot.item.family == "":
				tagText += "Seeds"
			else:
				tagText += slot.item.family
		2 :
			if slot.item.family == "":
				tagText += "Crop"
			else:
				tagText += slot.item.family
		3 :
			if slot.item.family == "":
				tagText += "Resource"
			else:
				tagText += slot.item.family
		4 :
			tagText += "Tool"
		5 :
			tagText += "Headgear"
		6 :
			tagText += "Chestwear"
		7 :
			tagText += "Bottomwear"
		8 :
			tagText += "Footwear"
		9 :
			tagText += "Trinket"

	tagline.text = tagText
	
	
	
	
	# SET DISPLAY LORE
	lore.text = slot.item.lore
	
	
	
	
	
	# SET ITEM STATS OR HIDE IT
	
	var components = slot.item.components
	
	#used for resizing window height
	var statHeight : int = 0
	
	if components.has( "base_stats" ):
		
		var base_stat_lines = components.base_stats.get_lines()
		
		print("BSL: ", base_stat_lines)
		
		var text_to_show = ""
		
		for line in base_stat_lines:
			
			print("line: ", line)
			
			text_to_show += line
			text_to_show += '\n'
			
		stat_display.text = text_to_show
		stat_display.show()
		
		statHeight += 13
			
	else: 
		
		# Items without stats do not show anything at the bottom
		
		statHeight = 0
		
		stat_display.text = "No stats"
		stat_display.hide()
	
	
	print ("STAT DISPLAY: ", stat_display.text)
	
	show()
	
	
	# Auto size the item_info window ################
	var max_width = 114
	var height = 53
	
	# Add bonus height when there are stats
	height += statHeight
	
	# Add padding and set item_info size
	size = Vector2( max_width , height )

	
