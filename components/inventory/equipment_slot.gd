extends Inventory_Slot

@export var icon_path: NodePath
@onready var icon = get_node( icon_path ) 

@export  var type: Game_Enums.ITEM_TYPE 



func _ready():
	icon.texture = ItemManager.get_placeholder( type )


func set_item( new_item ): 
	get_parent().set_item( new_item)
	icon.hide()
	
func pick_item(): 
	get_parent().pick_item()
	icon.show()
	
func put_item( new_item ): 
	get_parent().put_item( new_item )
	icon.hide()

