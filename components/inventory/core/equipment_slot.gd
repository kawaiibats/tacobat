class_name Equipment_Slot extends Inventory_Slot

@export var icon_path: NodePath
@onready var icon = get_node( icon_path ) 

@export var type: Game_Enums.ITEM_TYPE 



func _ready():
	icon.texture = ItemManager.get_placeholder( type )


func set_item( new_item ): 
	super.set_item( new_item )
	icon.hide()
	
func pick_item(): 
	super.pick_item()
	icon.show()
	
func put_item( new_item ): 
	super.put_item( new_item )
	icon.hide()

