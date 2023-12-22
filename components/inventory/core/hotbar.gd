class_name Hotbar extends Scale_Control

@export var slot_container_path: NodePath
@onready var slot_container = get_node( slot_container_path ) as Control

@export var hotbarSize: int
var hotbar_slot_res = preload("res://components/inventory/core/hotbar_slot.tscn")

var slots : Array = []

var isChest = false

var debug = false




func _ready():
	for s in hotbarSize:
		var slot = hotbar_slot_res.instantiate()
		slot.key = str( s + 1 )
		slot_container.add_child( slot )
		slots.append( slot )
	SignalManager.emit_signal( "inventory_ready", self )

	SignalManager.emit_signal( "player_inventory_ready", self ) 
	
	



func add_item( item ):
	if (debug): print("running HOTBAR add_item()")
	
	if (debug): print("current HOTBAR slots in here:", slots)
	for s in slots:
		if s.try_put_item(item):
			
			if (debug): print("adding HOTBAR item: ", item.id)
			
			item._ready() # fix for chest items not displaying qty. 

			item = s.put_item( item )
			
			if not item:
				return null
				
	return item


