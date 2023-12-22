extends Node2D

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

var r_click_handled = false


var debug = false


func _ready():
	SignalManager.item_picked.connect(self._on_item_picked_up)
	SignalManager.inventory_ready.connect(self._on_inventory_ready)
	SignalManager.player_inventory_ready.connect(self._on_player_inventory_ready)
	SignalManager.item_dropped.connect(self._on_item_dropped)
	
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

func _on_item_picked_up( item, sender, quantity ):
	print("inv manager, detected an item has been picked up: ", item, ", with quantity of ", quantity)
	
	
	
	
	### ~~ If item already exists in an inventory, and the quantity is less than its stack size, and the item quantity is less than the remainder, it will be added
	### ~~ this will cancel placing the item in an empty slot unless there is some less over
	
	for i in player_inventories:
		for s in i.slots:
			if s.item and (s.item.id == item.id):
				print("found a match!")
				
				# can fit neatly into stack 
				if s.item.quantity + quantity <= s.item.stack_size:
					print("fits clean")
					
					sender.item_picked()
					
					s.item.quantity = s.item.quantity + quantity
					s.item._ready() # fix to display item quantity
				
					return
					
				# can fit partially into a stack
				if (s.item.quantity < s.item.stack_size) and (s.item.quantity + quantity > s.item.stack_size):
					print ("fits partially, topping off stack")
					
					var newQuant = quantity - (s.item.stack_size - s.item.quantity)
					print ("newQuant: ", newQuant)
					
					sender.set_quantity(newQuant)
					sender.item._ready()
					
					s.item.quantity = s.item.stack_size
					s.item._ready()
				
				
				
				
				
				
				
				# only stacks found are full
				
				## ~ nothing needed
					
			
	
	
	
	
	
	### ~~ If item doesn't exist in inventory, find an empty slot from top of player inventories as usual
	
	var iter = 0
	for i in player_inventories:
		iter = iter + 1
		
		print("displaying inventory: ", i)
		
		item.quantity = quantity
		
		
		item = i.add_item( item )  #add item validation and item overflow zone later
		
		if not item:
			print("item can go in ", i)
			
			sender.item_picked() #tell object its been picked up
			return # accept item
			
		if item:
			print("item can't go in ", i)
			
		if item and iter == len(player_inventories):
			
			print("Out of inventory space! Stashing item..")
		
		
		
		
		
		
		# THIS WILL :
		# Pick up the item
		# Check for the first open slot in a player invnetory and place the item in there
		# If it can't find that, puts it in hotbar
		# It it can't find that, puts it in the "stash" zone
		



func _on_player_inventory_ready ( inv ):
	player_inventories.append(inv)



# end item pickup WIP !!!!
##################














# Controls positioning the item in hand around mouse motion
func _input( event ):
	
	#print("EVENT:", event)
	
	if event is InputEventMouseButton: if event.pressed == true: 
		
		# without the wait, the click input executes before the item is even in hand, making tracking it to cursor impossible
		if !item_in_hand: 
			await get_tree().create_timer(0.01).timeout
		
		if ((event is InputEventMouseMotion) or (event is InputEventMouseButton)) and item_in_hand:
		
			#item_in_hand.visible = true
		
			if debug: print("^^^^ setting item in hand pos to input")
		
			#print("Item in hand pos:", item_in_hand.position)
			#print("Event pos:", event.position)
	
			# item in hand scaling and positioning depending on global scaling settings
			if (SettingsManager.scale >= 1):
				item_in_hand.position = (event.position / SettingsManager.scale) + (Vector2(-8, -8) * SettingsManager.scale)  # no idea why this breaks if i use a variable3
			else:
				item_in_hand.position = (event.position / SettingsManager.scale) + (Vector2(-8, -8)) # no idea why this breaks if i use a variable3
				
			
	
	if ((event is InputEventMouseMotion) or (event is InputEventMouseButton)) and item_in_hand:
		
		if debug: print("^^^^ setting item in hand pos to input")
		
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
	
	##print("ON GUI INPUT TRIGGER")

	if event.is_pressed() and not event.is_echo():
		
		##print("- BOTTLENECK GUI INPUT TRIGGER")
	
	
		# PICK UP HALF OF A STACK (SPLIT) AUTOMAGICALLY
	
		if slot.item and !item_in_hand:
			if !Input.is_action_just_pressed("shiftAlt") and Input.is_action_just_pressed("altInteract") and slot.item.quantity > 1:
				print("auto half pickup")
				
				# ensure right click isn't processed again by below code
				r_click_handled = true
				
				var auto_half = ceil(slot.item.quantity / 2)
		
				split_stack.emit_signal( "stack_splitted", slot , auto_half )
				
				#slot.item.set_quantity(auto_half)
				

		
	
		# OPEN UP THE ADVANCED SPLIT STACK MENU
		
		if Input.is_action_just_pressed("altInteract"):
			
			
			if Input.is_action_just_pressed("shiftAlt") and slot.item.quantity > 2 and item_in_hand == null:
				print("open advanced split menu")
				r_click_handled = true
				split_stack.display( slot )
			elif Input.is_action_just_pressed("shiftAlt") and slot.item.quantity == 2 and item_in_hand == null:
				print("advanced split menu switches -> to auto half pickup")
				r_click_handled = true
				split_stack.emit_signal( "stack_splitted", slot , ceil(slot.item.quantity / 2) )
			elif Input.is_action_just_pressed("shiftAlt") and slot.item.quantity == null and item_in_hand == null:
				print("no quantity")
		
		
		

		
		# PICK UP ITEMS, PUT DOWN ITEMS WITH LEFT CLICK ////
		
		if Input.is_action_just_pressed("primaryClick"):
			
			r_click_handled = false
			var had_empty_hand = item_in_hand != null
			
			
			print(slot, "left clicked on!")
			if item_in_hand:
				# prevents items of incorrect type placed in equipment slots
				if slot is Equipment_Slot and item_in_hand.type != slot.type:
					print("wrong item type, can't go in this slot!")
					return
			
				item_in_hand.z_index = 0 # fix for item in hand display on cursor
				
				item_in_hand_node.remove_child( item_in_hand )
				
			if item_in_hand: item_in_hand.visible = false ## Potentially fix phantom item display?
				
			print ("before:", item_in_hand)
			item_in_hand = await slot.put_item( item_in_hand )
			print ("after:", item_in_hand)
			if (item_in_hand): item_in_hand._ready() ##  fixes display of new item after putting down partial stack
			if item_in_hand: item_in_hand.visible = true ## 
			
			if item_in_hand:
				if had_empty_hand:
					item_offset = event.global_position - slot.global_position
				
				item_in_hand_node.add_child( item_in_hand )
			
			set_hand_position( get_global_mouse_position() )
			
			if slot.item: slot.item.visible = true # # 
			
			
			
			
		# NEW ---- PICK UP ITEMS, PUT DOWN PARTIAL ITEMS WITH RIGHT CLICK ////
		
		# right click input on slots only activates under precise logic 
		if (!r_click_handled): if (Input.is_action_just_pressed("altInteract")) and ((item_in_hand) and (item_in_hand.quantity >= 1)):

			var had_empty_hand = item_in_hand != null

			print(slot, "right clicked on!")
			if item_in_hand:
				# prevents items of incorrect type placed in equipment slots
				if slot is Equipment_Slot and item_in_hand.type != slot.type:
					print("wrong item type, can't go in this slot!")
					return

			if item_in_hand:
				
				print ("in hand R // before:", item_in_hand)
				print ("in hand R // quantity before: ", item_in_hand.quantity)

				if item_in_hand.quantity == 1:
					print("right click dropping LAST one -- put_item()")
					item_in_hand.z_index = 0 # fix for item in hand display on cursor
					item_in_hand_node.remove_child( item_in_hand )
					item_in_hand = await slot.put_item( item_in_hand )
				elif item_in_hand.quantity > 1:
					var new_item = ItemManager.get_item( item_in_hand.id ) 
					new_item.visible = false # # 
					print("right click dropping ONLY ONE from MANY -- creating and dropping single item in put_item()")
					item_in_hand.set_quantity(item_in_hand.quantity - 1)
					slot.put_item( new_item )
					set_hand_position( get_global_mouse_position() ) # #
					new_item.visible = true # #
					
			else:
				print("return")

			if item_in_hand:
				print ("R // after:", item_in_hand)
				print ("R // quantity after: ", item_in_hand.quantity)

			if item_in_hand:
				if had_empty_hand:
					item_offset = event.global_position - slot.global_position

				item_in_hand_node.add_child( item_in_hand )

			set_hand_position( event.global_position )
			
			
		# reset to allow more right clicks
		r_click_handled = false










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
	new_item.visible = false # # 
	new_item.quantity = new_quantity
	
	print("new item to be in hand: ", new_item, "its quantity: ", new_item.quantity)

	item_in_hand = new_item
	item_in_hand_node.add_child( item_in_hand )
	item_in_hand_node.get_child(0).set_quantity(new_quantity)
	
	set_hand_position( get_global_mouse_position() ) # #
	new_item.visible = true # #
	
	
	
	await get_tree().create_timer(0.1).timeout
	if item_in_hand_node.get_child(0):
		item_in_hand_node.get_child(0).show()
	else:
		print("!!! Error Null Item In hand Child")
	
	had_full_hand = false

	


# Throw hand item on the ground

func _on_item_dropped():
	
	if item_in_hand:
	
		var floor_item = ResourceManager.tscn[ "floor_item" ].instantiate()
		floor_item.itemInside = item_in_hand.id
		floor_item.set_quantity(item_in_hand.quantity)
		get_parent().add_child( floor_item )
		floor_item.position = get_global_mouse_position()
	
		item_in_hand_node.remove_child( item_in_hand )
		item_in_hand = null


