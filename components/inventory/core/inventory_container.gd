extends Draggable_Control

var debug = false



# item tooltip info on hover
@export var item_info_path: NodePath
@onready var item_info = get_node( item_info_path ) 



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
	item_info.hide()


func setSize():
	if debug: print("starting setSize() size.y: ", size.y)
	
	size.y = 91
	
	var inventorySizes = 0

	
	if debug: print("current_inventories:", current_inventories)
	for inv in current_inventories:
		
		if debug: print("inv size y:", inv.size.y)
		inventorySizes = inventorySizes + inv.size.y
		inventorySizes = inventorySizes + 3
		if debug: print("current total inventorySizes: ", inventorySizes)
	
	inventorySizes = inventorySizes + 20
	
	if debug: print("inventorySizes:", inventorySizes)
	
	var difference = inventorySizes - 91
	if debug: print("difference:", difference)
	
	if difference > 0:
		size.y += difference
		#size.y += 5
	else:
		#size.y += 5
		return
	
	if debug: print("final size.y:", size.y)
	
	
func _on_inventory_opened( inventory: Inventory ):
	if debug: print ("ON INVENTORY OPEN")
	
	if current_inventories.size() == 0:
		size.y = 91
	
	if current_inventories.has( inventory ):
		if debug: print("inventory container already has this inventory, return")
		return
	
	container.add_child.call_deferred( inventory )
	current_inventories.append ( inventory )
	
	setSize()
	
	show()
	
	
	
func _on_inventory_closed( inventory: Inventory ):
	if debug: print ("ON INVENTORY CLOSE")
	
	if current_inventories.size() == 0:
		size.y = 91
	
	if current_inventories.has( inventory ):
		container.remove_child( inventory )
		current_inventories.erase( inventory )
	
	setSize()
	item_info.hide()
	
	if current_inventories == []:
		hide()


func _on_close_button_pressed():
	close()
