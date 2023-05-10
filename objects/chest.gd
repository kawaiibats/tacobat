extends StaticBody2D

@export var size : int = 1
@export var inventory_name : String = "Chest"
@export var starting_items : Array = []

@onready var inventory : Inventory

func _init():
	inventory = preload("res://components/inventory/inventory.tscn").instantiate()
	

func _ready():
	print("chest on ready")
	
	inventory.inventory_size = size
	inventory.inventory_name = inventory_name
	
	for item in starting_items:
		print("item being added: ", item)
		inventory.add_item( ItemManager.get_item( item ))
	

	




