class_name Inventory_Slot extends TextureRect

@export var container_path: NodePath = "item_container"

@onready var container = get_node( container_path ) 

var item : Item
var whenready = false


var debug = false



func _ready():
	whenready = true
	if item:
		print("THE ITEM IS:", item)
		print("THE CONTAINER IS:", container)
		container.add_child.call_deferred(item)

func set_item( new_item ):
	
	print("activate set_item")
	
	if not new_item:
		container.remove_child( item )
	elif (whenready): 
		container.add_child ( new_item )
	
	#prints
	if debug: print("old item: ")
	if debug: if item: print(item.id)
	if debug: print("new_item:", new_item.id)

	# set new item	
	item = new_item


func try_put_item( new_item : Item ) -> bool:
	return new_item and not item or ( item.id == new_item.id and item.quantity < item.stack_size )


	
func put_item( new_item : Item) -> Item:
	
	print("activate put_item")
	
	if new_item:
		# prevents items of incorrect type placed in equipment slots
		# if slot is Equipment_Slot and item_in_hand.type != slot.type:
		# 	return
		
		if item:
			if item.id == new_item.id and item.quantity < item.stack_size:
				var remainder = item.add_item_quantity( new_item.quantity )
					
				if remainder < 1:
					return null
					
			else: 
				var temp_item = item
				container.remove_child( item )
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
