extends Inventory



@onready var head
@onready var torso 
@onready var bottom
@onready var feet
@onready var trinket1 
@onready var trinket2


func _ready():
	
	print("slot_container: ", slot_container)
	
	print("slot children: ", slot_container.get_children())
	
	for slot in slot_container.get_children():
		match slot.name:
			"equipment_head" : 
				head = slot
			"equipment_torso" :
				torso = slot
			"equipment_bottom" :
				bottom = slot
			"equipment_feet" : 
				feet = slot
			"equipment_trinket" : 
				trinket1 = slot
			"equipment_trinket2" : 
				trinket2 = slot
	
	print("head:", head)
	
	slots.append( head )
	slots.append( torso )
	slots.append( bottom )
	slots.append( feet )
	slots.append( trinket1 )
	slots.append( trinket2 )
	
	print ("SLOTS!!: ", slots)
	
	
	SignalManager.emit_signal( "inventory_ready", self )




func set_inventory_size( value ):
	inventory_size = value

