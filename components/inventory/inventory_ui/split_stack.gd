class_name Split_Stack extends Scale_Control

@export var qty_slider_path: NodePath
@onready var qty_slider = get_node( qty_slider_path ) 

@export var lbl_original_path: NodePath
@onready var lbl_original = get_node( lbl_original_path ) 

@export var lbl_new_path: NodePath
@onready var lbl_new = get_node( lbl_new_path ) 



var quantity
var new_quantity
var inventory_slot



func display( slot ):
	quantity = slot.item.quantity
	inventory_slot = slot
	qty_slider.max_value = quantity - 1
	qty_slider.min_value = 1
	qty_slider.step = 1
	qty_slider.value = int ( round ( quantity / 2 ) )
	set_labels()
	show()
	

func set_labels():
	lbl_original.text = str( qty_slider.value )
	# new_quantity = quantity - qty_slider.value inventory_slot
	# lbl_new_text 
	
	# ~~~~~~~~~ 37:50
	
	

