extends Button

@export var pause_path: NodePath
@onready var pause = get_node(pause_path)




func _on_pressed():
	print("settings button pressed.. ")
	pause.pauseGUI()

	
