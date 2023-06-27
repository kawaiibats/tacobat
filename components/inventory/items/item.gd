class_name Item extends TextureRect

# "red_mush"
@export var id : String

# "Red Mushroom"
@export var item_name : String 

# "Considered especially tasty by many foodies across the Isles."
@export var lore : String


# OVERRIDES THE WORD "FORAGABLE", "CROP", or "SEEDS" for a more intricate feel
# Only used by some. If there is no family it will say the type instead.
@export var family : String = ""





# FORAGY - Foragables are found on the ground and in bushes and other objects.
# SEED - Seeds are found in trees bushes and other objects. They can also be purchased.
# CROP - Crops are obtained from plants that are grown at the home.
# RESOURCE - Resources are found when objects are destroyed such as trees or ore rocks.
# TOOL - Tools are usable items which cannot be stacked
# EQUIPMENT_HEAD, EQUIPMENT_TORSO, EQUIPMENT_BOTTOM, EQUIPMENT_FEET, EQUIPMENT_TRINKET - Equipment are placed in special inventory slots and give bonuses

@export var type : Game_Enums.ITEM_TYPE








# RARITY IS ONLY USED BY FORAGYS, SEEDS, CROPS, MAYBE RESOURCES
# "None", Common", "Uncommon", "Rare", "Exceptional", "Exotic"
@export var rarity : Game_Enums.ITEM_RARITY










func _ready():
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	
	
	
