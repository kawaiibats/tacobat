extends Button

@export var settings_path: NodePath
@onready var settings = get_node(settings_path)




func _on_pressed():
	print("settings button pressed.. ")
	settings.settingsGUI()
	
	
