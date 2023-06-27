extends NinePatchRect


# "Red Mushroom" - ITEM NAME
@export var display_name_path: NodePath
@onready var display_name = get_node( display_name_path ) 


# "Common" + " " + "Foragy" -- ITEM RARITY (if there is one) + ITEM TYPE
# Coloured depending on the rarity
@export var tagline_path: NodePath
@onready var tagline = get_node( tagline_path )



@export var lore_path: NodePath
@onready var lore = get_node( lore_path )





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
			tagText += "Exceptional "
			tagline.label_settings.font_color = Color.VIOLET
		
		5 : 
			tagText += "Exotic "
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
	
	
	show()

	
	
