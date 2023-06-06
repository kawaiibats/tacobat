class_name Chest extends StaticBody2D

@export var size : int = 1
@export var inventory_name : String = "Chest"
@export var starting_items : Array = []

@export var current_items : Array = []

@onready var inventory : Inventory

var debug = false


func _init():
	inventory = preload("res://components/inventory/inventory.tscn").instantiate()
	

func _ready():

	if (debug): print("chest on ready")
	
	inventory.inventory_name = inventory_name
	inventory.inventory_size = size
	inventory.chest_path = self.get_path()
	
	if (debug): print("chest parent:", get_parent())
	
	if (debug): print("chest path: ", inventory.chest_path)
	
	# Initialize chest inventory
	if(get_parent().unvisited == true):
		
		set_items(starting_items)
		
		current_items = starting_items.duplicate()
		
		if (debug): print("current_items: ", current_items)
		
	# Set chest inventory to its current inventory of items
	else:
		
		if (debug): print("current_items 2: ", current_items)
		
		set_items(current_items)
		
		

			
		
		

	
	
func set_items(items):
	for item in items:
		inventory.add_item( ItemManager.get_item( item ))
	

	



