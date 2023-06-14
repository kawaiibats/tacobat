class_name Item extends TextureRect

# "red_mush"
@export var id : String

# "Red Mushroom"
@export var item_name : String 



# Foragables are found on the ground and in bushes and other objects.
# Seeds are found in trees bushes and other objects. They can also be purchased.
# Crops are obtained from plants that are grown at the home.
# Resources are found when objects are destroyed such as trees or ore rocks.
# Tools are usable items which cannot be stacked
# Equipment are placed in special inventory slots and give bonuses

@export var type : Game_Enums.ITEM_TYPE


func _ready():
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	
	
	
