extends NinePatchRect

@export var container_path: NodePath
@onready var container = get_node( container_path ) 

@onready var current_inventories = container.get_children()


func _ready():
	SignalManager.inventory_opened.connect(self._on_inventory_opened)
	SignalManager.inventory_closed.connect(self._on_inventory_closed)
	setSize()

func close():
	for i in current_inventories:
		container.remove_child(i)
		
	current_inventories = []
	hide()


func setSize():
	print("starting setSize() size.y: ", size.y)
	
	size.y = 91
	
	var inventorySizes = 0
	
	if current_inventories.is_empty():
		return
	

	
	print("current_inventories:", current_inventories)
	for inv in current_inventories:
		print("inv size y:", inv.size.y)
		inventorySizes = inventorySizes + inv.size.y
		inventorySizes = inventorySizes + 3
		
	inventorySizes = inventorySizes - 3
	
	var difference = inventorySizes - 91
	print("difference:", difference)
	
	if difference > 0:
		size.y += difference
		#size.y += 5
	else:
		#size.y += 5
		return
	
	print("final size.y:", size.y)
	
	
func _on_inventory_opened( inventory: Inventory ):
	print ("ON INVENTORY OPEN")
	
	if current_inventories.size() == 0:
		size.y = 91
	
	if current_inventories.has( inventory ):
		print("inventory container already has this inventory, return")
		return
	
	container.add_child( inventory )
	current_inventories.append ( inventory )
	
	setSize()
	
	show()
	
	
	
func _on_inventory_closed( inventory: Inventory ):
	print ("ON INVENTORY CLOSE")
	
	if current_inventories.size() == 0:
		size.y = 91
	
	if current_inventories.has( inventory ):
		container.remove_child( inventory )
		current_inventories.erase( inventory )
	
		setSize()
	if current_inventories == []:
		hide()


func _on_close_button_pressed():
	close()
