class_name Equipment_Slot extends Inventory_Slot

@export var icon_path: NodePath
@onready var icon = get_node( icon_path ) 

@export var type: Game_Enums.ITEM_TYPE 



func _ready():
	icon.texture = ItemManager.get_placeholder( type )


func try_put_item( new_item : Item ) -> bool:
	return new_item.equipment_type == type and get_owner().try_put_item( new_item )

	
func put_item( new_item : Item ) -> Item: 
	if new_item.equipment_type != type:
		return new_item
		
		icon.hide()
	else:
		icon.show()
		
	
	return get_owner().put_item( new_item )

