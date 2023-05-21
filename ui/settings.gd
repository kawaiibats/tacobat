extends Scale_Control

@export var scale_slider_path: NodePath
@onready var scale_slider = get_node( scale_slider_path ) as HSlider


func _physics_process(_delta):
	if Input.is_action_just_pressed("openSettings"):
		settingsGUI()


func settingsGUI():
	if (visible):
		hide()
	else:
		show()




func _on_close_button_pressed():
	hide()
	
	


func _on_scale_slider_gui_input(event):
	if Input.is_action_just_released("primaryClick"):
		print("activate scaling settings ///")
		print("old scale: ", SettingsManager.scale)
		print("new scale:", scale_slider.value)
		SettingsManager.set_scale(scale_slider.value)
		
		
func _on_fullscreen_toggled( button_pressed ):
	print("fullscreen button toggled")
	print("returning: ", button_pressed)
	#SettingsManager.fullscreen = button_pressed
	SettingsManager.set_fullscreen(button_pressed)
