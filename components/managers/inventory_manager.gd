extends Node

@export var item_hand_path: NodePath
@onready var item_in_hand_node = get_node( item_hand_path ) 

@export var item_info_path: NodePath
@onready var item_info = get_node( item_info_path ) 

@export var split_stack_path: NodePath
@onready var split_stack = get_node( split_stack_path )


var player_inventories : Array = []
var inventories : Array = []
var item_in_hand : Item = null
var item_offset = Vector2(-8, -8)

var had_full_hand = true

func _ready():
	SignalManager.item_picked.connect(self._on_item_picked_up)
	SignalManager.inventory_ready.connect(self._on_inventory_ready)
	SignalManager.player_inventory_ready.connect(self._on_player_inventory_ready)
	
	split_stack.stack_splitted.connect(self._on_stack_splitted)


func _on_inventory_ready ( inventory ):

	inventories.append ( inventory )
	
	for slot in inventory.slots:
		#print("slotname:", slot)
		slot.mouse_entered.connect(self._on_mouse_entered_slot.bind(slot) )
		slot.mouse_exited.connect(self._on_mouse_exited_slot)
		slot.gui_input.connect(self._on_gui_input_slot.bind(slot) )
		




##################
# WIP !!!!

func _on_item_picked_up( item, sender ):
	print("inv manager, detected an item has been picked up: ", item)
	
	for i in player_inventories:
		item = i.add_item( item )  #add item validation and item overflow zone later
		if not item:
			sender.item_picked() #tell object its been picked up
			return # accept item
		
		
		
		# THIS WILL :
		# Pick up the item
		# Check for the first open slot in a player invnetory and place the item in there
		# If it can't find that, puts it in hotbar
		# It it can't find that, puts it in the "stash" zone
		

		return

func _on_player_inventory_ready ( inv ):
	player_inventories = inv



# end item pickup WIP !!!!
##################



# Controls positioning the item in hand around mouse motion
func _input( event : InputEvent ):
	
	if event is InputEventMouseMotion and item_in_hand:
		
		#print("Item in hand pos:", item_in_hand.position)
		#print("Event pos:", event.position)
	
		# item in hand scaling and positioning depending on global scaling settings
		if (SettingsManager.scale >= 1):
			item_in_hand.position = (event.position / SettingsManager.scale) + (Vector2(-8, -8) * SettingsManager.scale)  # no idea why this breaks if i use a variable3
		else:
			item_in_hand.position = (event.position / SettingsManager.scale) + (Vector2(-8, -8)) # no idea why this breaks if i use a variable3
		

func _on_mouse_entered_slot( slot : Inventory_Slot ):
	if slot.item:
		item_info.display( slot )

func _on_mouse_exited_slot():
	item_info.hide()
	
	
	
	
func _on_gui_input_slot( event : InputEvent, slot : Inventory_Slot ):
	
	#~~
	
	print("ON GUI INPUT TRIGGER")

	if event.is_pressed() and not event.is_echo():
		
		print("- BOTTLENECK GUI INPUT TRIGGER")
	
	
		# PICK UP HALF OF A STACK (SPLIT) AUTOMAGICALLY
	
		if slot.item:
			if !Input.is_action_just_pressed("shiftAlt") and Input.is_action_just_pressed("altInteract") and slot.item.quantity > 1 and item_in_hand == null:
				print("auto half pickup")
		
				split_stack.emit_signal( "stack_splitted", slot , ceil(slot.item.quantity / 2) )
		
	
		# OPEN UP THE ADVANCED SPLIT STACK MENU
		
		if Input.is_action_just_pressed("altInteract"):
			if Input.is_action_just_pressed("shiftAlt") and slot.item.quantity > 2 and item_in_hand == null:
				print("open advanced split menu")
				split_stack.display( slot )
			elif Input.is_action_just_pressed("shiftAlt") and slot.item.quantity == 2 and item_in_hand == null:
				print("advanced split menu switches -> to auto half pickup")
				split_stack.emit_signal( "stack_splitted", slot , ceil(slot.item.quantity / 2) )
			elif Input.is_action_just_pressed("shiftAlt") and slot.item.quantity == null and item_in_hand == null:
				print("no quantity")
		
		
		

		
		# PICK UP ITEMS, PUT DOWN ITEMS WITH LEFT CLICK ////
		
		if Input.is_action_just_pressed("primaryClick"):
			
			var had_empty_hand = item_in_hand != null
			
			
			print(slot, "left clicked on!")
			if item_in_hand:
				# prevents items of incorrect type placed in equipment slots
				if slot is Equipment_Slot and item_in_hand.type != slot.type:
					print("wrong item type, can't go in this slot!")
					return
			
				item_in_hand.z_index = 0 # fix for item in hand display on cursor
				item_in_hand_node.remove_child( item_in_hand )
				
			print ("before:", item_in_hand)
			item_in_hand = await slot.put_item( item_in_hand )
			print ("after:", item_in_hand)
			
			if item_in_hand:
				if had_empty_hand:
					item_offset = event.global_position - slot.global_position
				
				item_in_hand_node.add_child( item_in_hand )
			
			set_hand_position( event.global_position )
		


func set_hand_position( pos ):
	if item_in_hand:
		item_in_hand.z_index = 0 # fix for item in hand display on cursor
		item_in_hand.position = ( pos - item_offset ) / SettingsManager.scale


func _on_stack_splitted( slot, new_quantity ):
	print("on_stack_splitted: ", slot, " quantity: ", new_quantity)
	
	print("old quantity: ", slot.item.quantity)
	slot.item.quantity -= new_quantity
	slot.item.set_quantity(slot.item.quantity)
	
	var new_item = ItemManager.get_item( slot.item.id )
	new_item.quantity = new_quantity
	
	print("new item to be in hand: ", new_item, "its quantity: ", new_item.quantity)
	
	new_item.visible = false
	
	item_in_hand = new_item
	item_in_hand_node.add_child( item_in_hand )
	item_in_hand_node.get_child(0).set_quantity(new_quantity)
	set_hand_position( slot.global_position )
	
	
	await get_tree().create_timer(0.1).timeout
	item_in_hand_node.get_child(0).show()
	
	had_full_hand = false

	

	


