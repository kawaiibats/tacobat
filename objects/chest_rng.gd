extends Chest


@export var num_of_items : int



func set_items(items):
	
	for nb in num_of_items:
				
		var random_id = starting_items[randi() % starting_items.size()]
		print("random_id:", random_id)
		
		inventory.add_item ( ItemManager.get_item(random_id))

func _ready() -> void:
	super._ready()
