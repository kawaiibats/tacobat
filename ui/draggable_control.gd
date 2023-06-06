class_name Draggable_Control extends Scale_Control

@export var x_safe_zone : int = 50
@export var y_safe_zone : int = 50

var screen_size : Vector2
var dragging : bool = false
var offset : Vector2



func _ready():
	gui_input.connect(self._on_gui_input)
	screen_size = DisplayServer.window_get_size()


	
func _process( delta ):
	if dragging:
		set_pos( get_viewport().get_mouse_position() - offset ) 



func set_ui_scale2 ( value ):
	set_ui_scale( value )
	
	set_pos( position )



func set_pos( pos ):
	
	var scaled_size = size * scale
	
	
	screen_size = DisplayServer.window_get_size()
	
	
	pos.x = clamp( pos.x, -scaled_size.x + x_safe_zone, (screen_size.x / 4.6) - x_safe_zone)
	pos.y = clamp( pos.y, -scaled_size.y + y_safe_zone, (screen_size.y / 4) - y_safe_zone)
	position = pos


	print ("size: ", size)
	print("SET POSITION TO: ", position)
	print("SCREEN_SIZE: ", screen_size)

	
func _on_gui_input( event : InputEvent ):
	#print(" on gui input !")
	
	if !dragging and event.is_action_pressed( "primaryClick" ):
		print("dragging clicked!")
		var mouse_pos = get_viewport().get_mouse_position()
		offset = mouse_pos - position
		dragging = true
		get_viewport().set_input_as_handled()
		print("position:", position)
		print("offset: ", offset)
		
	if dragging and event.is_action_released( "primaryClick" ): 
		dragging = false
		get_viewport().set_input_as_handled()
		
		
		
		
