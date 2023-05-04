class_name Inventory extends NinePatchRect

var inventory_slot_res = preload("res://components/inventory/inventory_slot.tscn")



@export var inventory_name: String
@export var inventory_size: int = 0 :
	set(value):
		inventory_size = value
		custom_minimum_size.y = 50 + ( ceil( inventory_size / 5.0 ) - 1 ) * 24
	
		for s in inventory_size:
			var new_slot = inventory_slot_res.instantiate()
			slots.append( new_slot )
	get:
		return inventory_size

@export var title_path: NodePath
@onready var title = get_node( title_path ) 

@export var slot_path: NodePath
@onready var slot_container = get_node( slot_path ) 

var slots : Array = []



func _ready():
	for s in slots:
		slot_container.add_child( s )
	
	title.text = "- " + inventory_name + " -"
	

	

func add_item( item ):
	for s in slots:
		if not s.item:
			#add item to slot
			return





