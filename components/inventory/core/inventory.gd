class_name Inventory extends NinePatchRect

var inventory_slot_res = preload("res://components/inventory/core/inventory_slot.tscn")


@export var inventory_name: String
@export var inventory_size: int = 0

@export var title_path: NodePath
@onready var title = get_node( title_path ) 
 
@export var slot_path: NodePath
@onready var slot_container = get_node( slot_path ) 

var slots : Array = []

var debug = false




# current items in inventory
@export var current_items : Array = []




# optional chest variables
@export var chest_path : NodePath
@onready var chest = get_node( chest_path )



func _ready():
	if (debug): print("inventory on _ready")

	set_title()

	if (debug): print("InvSize:", inventory_size)

	set_inventory_size(inventory_size)

	add_slots()
	
	SignalManager.emit_signal( "inventory_ready", self )




func set_title():
	title.text = "- " + inventory_name + " -"





	

func set_inventory_size(value):
	inventory_size = value
	
	
	size.y = 43 + ( ceil( inventory_size / 7.0 ) - 1 ) * 24
	custom_minimum_size.y = size.y

	
	if slots == []:
		for s in inventory_size:
			if (debug): print("appending new slot")
			var new_slot = inventory_slot_res.instantiate()
			slots.append( new_slot )
		
	if (debug): print("slots:", slots)

func add_slots():
	for s in slots:
		slot_container.add_child.call_deferred( s )
	#print("slot container children:", slot_container.get_children())



############################

	
	

func add_item( item ):
	await self._ready()
	
	if (debug): print("running add_item()")
	
	if (debug): print("current slots in here:", slots)
	for s in slots:
		if not s.item:
			if (debug): print("adding item: ", item.id)
			s.set_item ( item )

			
			return





