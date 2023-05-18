extends Scale_Control

var print_debug = false

@export var inventory_path: NodePath
@onready var inventory = get_node( inventory_path ) as Inventory

#hotbar etc here ~

@onready var players_inventories = inventory.get_parent().get_children()




func _ready():
	setSize()
	
	var inventories = [ inventory ] #, hotbar, etc
	SignalManager.emit_signal( "player_inventory_ready", inventories ) 


func _physics_process(_delta):
	if Input.is_action_just_pressed("openInventories"):
		inventoryGUI()


func close():
	#not needed for player inventory, it stays always
	#for i in players_inventories:
		#remove_child(i)
		
	#players_inventories = []
	hide()


func setSize():
	if print_debug: print("starting setSize() size.y: ", size.y)
	
	size.y = 91
	
	var inventorySizes = 0

	
	if print_debug: print("players_inventories:", players_inventories)
	for inv in players_inventories:
		
		if print_debug: print("inv size y:", inv.size.y)
		inventorySizes = inventorySizes + inv.size.y
		inventorySizes = inventorySizes + 3
		if print_debug: print("current total inventorySizes: ", inventorySizes)
	
	inventorySizes = inventorySizes + 20
	
	if print_debug: print("inventorySizes:", inventorySizes)
	
	var difference = inventorySizes - 91
	if print_debug: print("difference:", difference)
	
	if difference > 0:
		size.y += difference
		#size.y += 5
	else:
		#size.y += 5
		return
	
	if print_debug: print("final size.y:", size.y)
	
	
	


func inventoryGUI():
	if (visible):
		hide()
	else:
		show()


func _on_close_button_pressed():
	close()
	
	
	
	
	
	
############################

	
	

