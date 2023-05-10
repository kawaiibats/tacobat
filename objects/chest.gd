class_name Chest extends StaticBody2D

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
	set_items(starting_items)
	
func set_items(items):
	for item in items:
		inventory.add_item( ItemManager.get_item( item ))
	

	




