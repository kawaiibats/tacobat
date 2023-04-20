extends Node

#var distance2Player = player


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
			print("Bush Clicked! Here is where the stuff that executes goes.")
			

