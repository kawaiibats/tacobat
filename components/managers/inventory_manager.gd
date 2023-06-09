extends Node

@export var item_hand_path: NodePath
@onready var item_in_hand_node = get_node( item_hand_path ) 

@export var item_info_path: NodePath
@onready var item_info = get_node( item_info_path ) 


var player_inventories : Array = []
var inventories : Array = []
var item_in_hand : Item = null
var item_offset = Vector2(-8, -8)

func _ready():
	SignalManager.item_picked.connect(self._on_item_picked_up)
	SignalManager.inventory_ready.connect(self._on_inventory_ready)
	SignalManager.player_inventory_ready.connect(self._on_player_inventory_ready)


func _on_inventory_ready ( inventory ):

	inventories.append ( inventory )
	
	for slot in inventory.slots:
		print("slotname:", slot)
		slot.mouse_entered.connect(self._on_mouse_entered_slot.bind(slot) )
		slot.mouse_exited.connect(self._on_mouse_exited_slot)
		slot.gui_input.connect(self._on_gui_input_slot.bind(slot) )
		



func _on_item_picked_up( item ):
	print("inv manager, detected an item has been picked up: ", item)
	
	for i in player_inventories:
		i.add_item( item )  #add item validation and item overflow zone later
		

		return

func _on_player_inventory_ready ( inv ):
	player_inventories = inv



func _input( event : InputEvent ):
	if event is InputEventMouseMotion and item_in_hand:
		#print("Item in hand pos:", item_in_hand.position)
		#print("Event pos:", event.position)
		item_in_hand.position = event.position + Vector2(-8, -8) # no idea why this breaks if i use a variable3





func _on_mouse_entered_slot( slot : Inventory_Slot ):
	if slot.item:
		item_info.display( slot )

func _on_mouse_exited_slot():
	item_info.hide()
	
func _on_gui_input_slot( event : InputEvent, slot : Inventory_Slot ):
	if Input.is_action_just_pressed("primaryClick"):
		#print(slot, "clicked on!")
		if item_in_hand:
			# prevents items of incorrect type placed in equipment slots
			if slot is Equipment_Slot and item_in_hand.type != slot.type:
				return
			

			item_in_hand_node.remove_child(item_in_hand)
			
			if slot.item:
				var temp_item = slot.item
				slot.pick_item()
				temp_item.global_position = event.global_position - item_offset
				slot.put_item( item_in_hand )
				item_in_hand = temp_item
				item_in_hand_node.add_child.call_deferred (item_in_hand)
				
			else:
				slot.put_item( item_in_hand )
				
				# placing into a chest
				if slot.container.get_parent().get_parent().get_parent().chest:
					print("APPENDING 2: ", slot.container.get_parent().get_parent().get_parent().chest.current_items)
					slot.container.get_parent().get_parent().get_parent().chest.current_items.append(item_in_hand.id)
					
				item_in_hand = null
				
		elif slot.item:
			item_in_hand = slot.item
			item_offset = event.global_position - item_in_hand.global_position
			slot.pick_item()
			item_in_hand_node.add_child( item_in_hand )
			item_in_hand.global_position = event.global_position - item_offset
			
		


