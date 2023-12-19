class_name Item extends TextureRect

###############################################
#                                             #
#                ITEM DATA !!                 #
#                                             #
###############################################

# ID
# "red_mush"
var id : String

# ITEM NAME
# "Red Mushroom"
var item_name : String 

# ITEM LORE
# "Considered especially tasty by many foodies across the Isles."
var lore : String

# ITEM FAMILY
# OVERRIDES THE WORD "FORAGABLE", "CROP", or "SEEDS" for a more intricate feel
# Only used by some. If there is no family it will say the type instead.
var family : String = ""

# ITEM TYPE # # # # # # # #
# Foragy - Foragables are found on the ground and in bushes and other objects.
# Seed - Seeds are found in trees bushes and other objects. They can also be purchased.
# Crop - Crops are obtained from plants that are grown at the home.
# Resource - Resources are found when objects are destroyed such as trees or ore rocks.
# Tool - Tools are usable items which cannot be stacked
# 
# Equipment - Equipment are placed in special inventory slots and give bonuses
# Come in multiple types: EQUIPMENT_HEAD, EQUIPMENT_TORSO, EQUIPMENT_BOTTOM, EQUIPMENT_FEET, EQUIPMENT_TRINKET 

var type : Game_Enums.ITEM_TYPE

# RARITY IS ONLY USED BY FORAGYS, SEEDS, CROPS, MAYBE RESOURCES
# "None", Common", "Uncommon", "Rare", "Exceptional", "Exotic"
var rarity : Game_Enums.ITEM_RARITY

# MAX STACK SIZE
var stack_size : int = 1

# QUANTITY
var quantity : int = 1

# SPECIAL ITEM DATA (Stats, usable item functionality, etc)
var components = {}



# label for item quantity
var lbl_quantity = null





func _init( item_id, data ):
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	# Required 
	id = item_id
	item_name = data.name
	type = data.type
	
	texture = ResourceManager.sprites[ id ]
	
	# Optional
	if data.has( "stack_size" ): 
		stack_size = data.stack_size
	if data.has( "rarity" ): 
		rarity = data.rarity
	if data.has( "family" ): 
		family = data.family
	if data.has( "lore" ): 
		lore = data.lore
	
	if data.has( "base_stats" ):
		components[ "base_stats" ] = Base_Stat.new( data.base_stats )


func _ready():
	if lbl_quantity == null: # This is necessary to prevent creating extra labels
		lbl_quantity = Label.new()
		lbl_quantity.label_settings = load("res://font/quantity.tres")
		add_child( lbl_quantity )
	set_quantity( quantity )
	
func set_quantity( value ):
	quantity = value
	
	if lbl_quantity:
		lbl_quantity.text = str( quantity )
		lbl_quantity.visible = quantity > 1
		lbl_quantity.scale = Vector2(0.35,0.35)

func add_item_quantity( value ):
	var remainder = quantity + value - stack_size
	quantity = min( quantity + value, stack_size )
	set_quantity( quantity )
	return remainder
	
	
