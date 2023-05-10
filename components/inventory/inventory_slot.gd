class_name Inventory_Slot extends TextureRect

@export var container_path: NodePath
@onready var container = get_node( container_path ) 

var item


func _ready():
	if item:
		print("THE ITEM IS:", item)
		print("THE CONTAINER IS:", container)
		container.add_child(item)

func set_item( new_item ):
	print("old item:", item)
	print("new_item:", new_item)
	item = new_item

func pick_item():
	item.pick_item()
	container.remove_child(item)
	#new
	get_parent().get_parent().current_items.erase(item)
	item = null
	
func put_item( new_item ):
	item = new_item
	item.put_item()
	container.add_child(item)
