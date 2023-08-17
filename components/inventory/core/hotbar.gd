class_name Hotbar extends Scale_Control

@export var slot_container_path: NodePath
@onready var slot_container = get_node( slot_container_path ) as Control

@export var hotbarSize: int
var hotbar_slot_res = preload("res://components/inventory/core/hotbar_slot.tscn")

var slots : Array = []

var isChest = false

func _ready():
	for s in hotbarSize:
		var slot = hotbar_slot_res.instantiate()
		slot.key = str( s + 1 )
		slot_container.add_child( slot )
		slots.append( slot )
	SignalManager.emit_signal( "inventory_ready", self )

