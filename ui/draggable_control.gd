class_name Draggable_Control extends Scale_Control

@export var x_safe_zone : int = 100
@export var y_safe_zone : int = 75

var dragging : bool = false
var offset : Vector2


func _ready():
	get_viewport().size_changed.connect(self._on_size_changed)




func _input( event ):
	if event is InputEventMouseMotion and dragging:
		set_pos( event.position - offset ) 



func set_ui_scale2 ( value ):
	set_ui_scale( value )
	
	set_pos( position )



func set_pos( pos ):
	
	var scaled_size = size * scale
	

	var screen_size : Vector2 = DisplayServer.window_get_size()
	
	pos.x = clamp( pos.x, -size.x + x_safe_zone, (screen_size.x / 4) - x_safe_zone )
	pos.y = clamp( pos.y, -size.y + y_safe_zone, (screen_size.y / 4) - y_safe_zone )
	position = pos

	print("size: ", size)
	print("scale: ", scale)


	print ("scaled_size: ", scaled_size)
	print("SET POSITION TO: ", position)
	print("SCREEN_SIZE: ", screen_size)

	
func _gui_input( event : InputEvent ):
	
	if event.is_action_pressed( "primaryClick" ): 
		print(" start drag! ")
		var mouse_pos = get_viewport().get_mouse_position()
		offset = mouse_pos - position
		dragging = event.is_action_pressed( "primaryClick" )
		
	if dragging and event.is_action_released( "primaryClick" ):
		dragging = event.is_action_pressed( "primaryClick" )

	
func _on_size_changed():
	set_pos( position )
