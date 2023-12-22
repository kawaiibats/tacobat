extends Draggable_Control

var print_debug = false

# item tooltip info on hover

@export var item_info_path: NodePath
@onready var item_info = get_node( item_info_path ) 




#all inventories including hotbar etc will be here ~

@export var inventory_path: NodePath
@onready var inventory = get_node( inventory_path ) as Inventory

@export var pockets_path: NodePath
@onready var pockets = get_node( pockets_path ) as Inventory

@export var hotbar_path: NodePath
@onready var hotbar = get_node( hotbar_path ) as Inventory


# ~~~












@onready var players_inventories = inventory.get_parent().get_children()




func _ready():
	setSize()
	
	var inventories = [ inventory, pockets ] #, hotbar, backpack, etc
	for inv in inventories:
		SignalManager.emit_signal( "player_inventory_ready", inv ) 
		



func _physics_process(_delta):
	if Input.is_action_just_pressed("openInventories"):
		inventoryGUI()


func close():
	#not needed for player inventory, it stays always. If there is some kind of temporary inventory maybe
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
		## hide tooltip if an item is being hovered when the gui is closed
		item_info.hide()
		
		
	else:
		show()


func _on_close_button_pressed():
	close()
	
	
	
	
	
	
############################

	
	

