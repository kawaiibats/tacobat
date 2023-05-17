class_name Inventory_Slot extends TextureRect

@export var container_path: NodePath = "item_container"

@onready var container = get_node( container_path ) 

var item
var whenready = false


var debug = false



func _ready():
	whenready = true
	if item:
		print("THE ITEM IS:", item)
		print("THE CONTAINER IS:", container)
		container.add_child.call_deferred(item)

func set_item( new_item ):
	var item_container = get_node("item_container")
	
	if not new_item:
		item_container.remove_child ( item )
	else: 
		item_container.add_child ( new_item )
	
	#prints
	if debug: print("old item: ")
	if debug: if item: print(item.id)
	if debug: print("new_item:", new_item.id)
	
	item = new_item
	

func pick_item():
	item.pick_item()
	
	print("pick item wip ID: ", item.id)
	
	print("pick item wip pos ", item.position)
	
	# chest inventory updating ?
	if container.get_parent().get_parent().get_parent().chest:
		print("TESTWIP: ", container.get_parent().get_parent().get_parent().chest.current_items)
	
		container.get_parent().get_parent().get_parent().chest.current_items.erase(item.id)
	
	container.remove_child(item)
	item = null

	
func put_item( new_item : Item) -> Item:
	if new_item:
		if item:
			#if item.id == new_item.id and item.quantity < item.stack_size:
				#var remainder = item.add_item_quantity( new_item.quantity )
				
				#if remainder < 1:
					#return null
			if true:
				var temp_item = item
				container.remove_child( item )
				
				# ?
				print("APPEND: ", container.get_parent().get_parent().get_parent().chest.current_items.item.id)
				container.get_parent().get_parent().get_parent().chest.current_items.append(item.id)
				
				set_item( new_item )
				new_item = temp_item
			
			return new_item
		else:
			set_item( new_item )
			return null
	elif item:
		new_item = item
		set_item( null )
	
	return new_item
	

func item_picked():
	container.queue_free()
