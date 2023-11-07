extends Scale_Control




# settings
@export var scale_slider_path: NodePath
@onready var scale_slider = get_node( scale_slider_path ) as HSlider

@export var label_min_path: NodePath
@onready var label_min = get_node( label_min_path ) as Label

@export var label_max_path: NodePath
@onready var label_max = get_node( label_max_path ) as Label




# tabs
@export var tab_list_path: NodePath
@onready var tab_list = get_node( tab_list_path ) as Control

@export var settings_tab_path: NodePath
@onready var settings_tab = get_node( settings_tab_path ) as Control

@export var equipment_tab_path: NodePath
@onready var equipment_tab = get_node( equipment_tab_path ) as Control





var selected_tab = "settings"





func _physics_process(_delta):
	if Input.is_action_just_pressed("openSettings"):
		pauseGUI()


func _ready():
	label_min.text = "Min: %s" % scale_slider.min_value
	label_max.text = "Max: %s" % scale_slider.max_value





# Show or hide entire pause menu

func pauseGUI():
	if (visible):
		print("hideme")
		hide()
	else:
		print("showme")
		show()



# Flip to a single tab of pause menu

func update_tab ( value ):
	if value == "settings":
		for child in tab_list.get_children():
			print("child hiding: ", child)
			child.hide()
		print("child showing:", settings_tab)
		settings_tab.show()
		selected_tab = "settings"
	if value == "equipment":
		for child in tab_list.get_children():
			print("child hiding: ", child)
			child.hide()
		print("child showing:", equipment_tab)
		equipment_tab.show()
		selected_tab = "equipment"
		
	setSize()
	
	



func setSize():
	size.y = 97
	
	var content_sizes = 0
	
	match selected_tab:
		"settings" : 
			
			for child in settings_tab.get_child(0).get_children():
				
				print ("adding size of ", child, child.size.y)
				
				content_sizes = content_sizes + child.size.y
				content_sizes = content_sizes + 3

		"equipment" : 
			
			for child in equipment_tab.get_child(0).get_children():
				
				print ("adding size of ", child, child.size.y)
				
				content_sizes = content_sizes + child.size.y
				content_sizes = content_sizes + 3
		
		
		
			content_sizes = content_sizes + 21
			print("final content size: ", content_sizes)
			
			var difference = content_sizes - 97
			print("difference:", difference)
	
			if difference > 0:
				size.y += difference
				print ("adjusting")
			else:
				pass
			
			print("final settings size.y:", size.y)			

	# reset settings menu to be centered (necessary for when it is resized)
	anchors_preset = 8


# Pause Screen buttons

func _on_tab_settings_pressed():
	update_tab("settings")

func _on_tab_equipment_pressed():
	update_tab("equipment")


# close button

func _on_close_button_pressed():
	hide()
	
	




# Settings

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





