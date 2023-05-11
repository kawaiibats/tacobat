class_name Inventory_Slot extends TextureRect

@export var container_path: NodePath
@onready var container = get_node( container_path ) 

var item


func _ready():
	if item:
		print("THE ITEM IS:", item)
		print("THE CONTAINER IS:", container)
		container.add_child.call_deferred(item)

func set_item( new_item ):
	print("old item:", item)
	print("new_item:", new_item)
	item = new_item
	

func pick_item():
	item.pick_item()
	
	print("item wip ID: ", item.id)
	print("TESTWIP: ", container.get_parent().get_parent().get_parent().chest.current_items)
	
	# chest inventory updating ?
	container.get_parent().get_parent().get_parent().chest.current_items.erase(item.id)
	
	container.remove_child(item)
	item = null
	
func put_item( new_item ):
	item = new_item
	item.put_item()
	
	# chest inventory updating ?
	if container.get_parent().get_parent().get_parent().chest:
		container.get_parent().get_parent().get_parent().chest.current_items.append(item.id)
	
	container.add_child.call_deferred(item)
	

