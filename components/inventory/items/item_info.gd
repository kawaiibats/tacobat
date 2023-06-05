extends NinePatchRect

@export var item_path: NodePath
@onready var item = get_node( item_path ) 

func display( slot : Inventory_Slot ):
	self.global_position = slot.size + slot.global_position
	
	item.text = slot.item.item_name
	
	show()

	
	
