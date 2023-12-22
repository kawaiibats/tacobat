class_name Inventory_Slot extends TextureRect

signal item_changed()


@export var container_path: NodePath

@onready var container = get_node( container_path ) 

var item : Item
var whenready = false


var debug = false



func _ready():
	whenready = true
	if item:
		#print("THE ITEM IS:", item)
		#print("THE CONTAINER IS:", container)
		container.add_child.call_deferred(item)

func set_item( new_item ):
	
	if debug: print("activate set_item")
	
	if not new_item:
		container.remove_child( item )
	elif (whenready): 
		container.add_child ( new_item )
		if debug: print("new_item TODO:", container.get_children)
	else:
		if debug: print("SET ITEM WASNT READY !!!!!")
	
	#prints
	if debug: if (item): if(item.id): print("old item: ", item.id)
	if debug: if (new_item): if(new_item.id): print("new_item:", new_item.id)

	# set new item	
	item = new_item


func try_put_item( new_item : Item ) -> bool:
	return new_item and not item or ( item.id == new_item.id and item.quantity < item.stack_size )


	
func put_item( new_item : Item) -> Item:
	print("activate put_item")
	
	
	# Activates when trying to place an item down in the slot
	if new_item:
		print( "putting item down")
		
		return has_new_item( new_item )


	# Activates when picking up item already in slot with an empty hand
	elif item:
		print( "picking item up" )
		
		new_item = item
		set_item( null )
	
	# return an item or null
	emit_signal( "item_changed" )
	return new_item



func has_new_item( new_item ):
	# if there is already an item in the slot
	if item:
		return has_both_item( new_item )
	
	# simply place the item in the empty slot
	else:
		set_item( new_item )
		emit_signal( "item_changed" )
		return null


func has_both_item( new_item ):
	print("Slot already has item, hand already has item")
	
	# Check if the item in hand and the one in the slot can be stacked
	if can_stack( new_item ):
		print("They can be stacked together")
		
		var remainder = item.add_item_quantity( new_item.quantity )
		new_item.quantity = remainder
		
		print("THE REMAINDER IS: ", remainder)
		print("the new item quantity is: ", new_item.quantity)
	
	# Swap the item in hand with the one in the slot
	else:
		print("They cannot be stacked -- swapping items")
		
		var temp_item = item
		remove_item_child()
		set_item( new_item )
		new_item = temp_item
		
	
	print("returning: ", new_item)
	
	return new_item if new_item.quantity > 0 else null


func can_stack( new_item ) -> bool:
	return item.id == new_item.id and item.quantity < item.stack_size
	

func remove_item_child():
	container.remove_child( item )
	

func remove_item():
	put_item( null )


func item_picked():
	container.queue_free()
