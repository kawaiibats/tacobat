class_name Hotbar_Slot extends Inventory_Slot

@export var lbl_key_path: NodePath
@onready var lbl_key = get_node( lbl_key_path ) as Label


var key



func _ready():
	lbl_key.text = key
	
	
func _input( event ):
	if Input.is_action_just_pressed("hotbar_" + key):
		print( "Activated hotbar slot: ", key)
