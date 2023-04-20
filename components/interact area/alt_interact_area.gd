class_name AltInteractable extends Area2D

@export var alt_interact_label = "none"
@export var alt_interact_type = "none"
@export var alt_interact_value = "none"

var clickedOn = false

func _on_input_event(viewport, event, shape_idx):
	clickedOn = true

func _on_mouse_exited():
	clickedOn = false
	
