class_name Inventory_Slot extends TextureRect

@export var container_path: NodePath = "item_container"

@onready var container = get_node( container_path ) 

var item : Item
var whenready = false


var debug = true



func _ready():
	whenready = true
	if item:
		#print("THE ITEM IS:", item)
		#print("THE CONTAINER IS:", container)
		container.add_child.call_deferred(item)

func set_item( new_item ):
	
	print("activate set_item")
	
	if not new_item:
		container.remove_child( item )
	elif (whenready): 
		container.add_child ( new_item )
		print("new_item TODO:", container.get_children)
	else:
		print("SET ITEM WASNT READY !!!!!")
	
	#prints
	if debug: if (item): if(item.id): print("old item: ", item.id)
	if debug: if (new_item): if(new_item.id): print("new_item:", new_item.id)

	# set new item	
	item = new_item


func try_put_item( new_item : Item ) -> bool:
	return new_item and not item or ( item.id == new_item.id and item.quantity < item.stack_size )


	
func put_item( new_item : Item) -> Item:
	
	print("activate put_item")
	
	if new_item:
		
		if item:
			
			if item.id == new_item.id and item.quantity < item.stack_size:
				
				print( "item qty: ", item.quantity)
				print( "new item qty: ", new_item.quantity)
				
				var remainder = item.add_item_quantity( new_item.quantity )
				
				print( "remainder: ", remainder )
					
				if remainder < 1:
					return null
				elif remainder >= 1: ## 
					new_item.quantity = remainder ## fix
					
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
