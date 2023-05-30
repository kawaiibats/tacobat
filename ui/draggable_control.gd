class_name Draggable_Control extends Scale_Control


var dragging : bool = false
var offset : Vector2



#func _ready():
	#gui_input.connect(self._on_gui_input)

	
func _process( delta ):
	if dragging:
		position = get_viewport().get_mouse_position() - offset
	
	
func _on_gui_input( event : InputEvent ):
	print(" on gui input !")
	
	if !dragging and event.is_action_pressed( "primaryClick" ):
		print("dragging clicked!")
		var mouse_pos = get_viewport().get_mouse_position()
		offset = mouse_pos - position
		dragging = true
		get_viewport().set_input_as_handled()
		
	if dragging and event.is_action_released( "primaryClick" ): 
		dragging = false
		get_viewport().set_input_as_handled()
		
		
		
		
