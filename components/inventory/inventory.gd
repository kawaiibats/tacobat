class_name Inventory extends NinePatchRect

var inventory_slot_res = preload("res://components/inventory/inventory_slot.tscn")


@export var inventory_name: String
@export var inventory_size: int = 0

@export var title_path: NodePath
@onready var title = get_node( title_path ) 

@export var slot_path: NodePath
@onready var slot_container = get_node( slot_path ) 

var slots : Array = []



func _ready():
	print("inventory on _ready")

	title.text = "- " + inventory_name + " -"

	print("InvSize:", inventory_size)

	set_inventory_size(inventory_size)

	add_slots()
	
	SignalManager.emit_signal( "inventory_ready", self )
	
	

func set_inventory_size(value):
	print("setting inventory size")
	inventory_size = value
	size.y = 43 + ( ceil( inventory_size / 7.0 ) - 1 ) * 24
	print("setting size to: ", size.y)
	
	if slots == []:
		for s in inventory_size:
			print("appending new slot")
			var new_slot = inventory_slot_res.instantiate()
			slots.append( new_slot )
		
	print("slots:", slots)

func add_slots():
	for s in slots:
		slot_container.add_child( s )
	print("slot container children:", slot_container.get_children())




############################

	
	

func add_item( item ):
	await self._ready()
	
	print("running add_item()")
	
	print("current slots in here:", slots)
	for s in slots:
		if not s.item:
			print("adding item: ", item)
			s.set_item ( item )
			return





