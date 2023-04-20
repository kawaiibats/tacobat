extends Node

var inRange = false
var distance2Player = 


func _input_event(viewport, event, shape_idx):
	if event.is_pressed() and inRange == true:
		print("Bush Clicked! Here is where the stuff that executes goes.")


func _on_area_entered(area):
	print("Entered Clickable Area for bush..")
	inRange = true

func _on_area_exited(area):
	print("Exited Clickable Area for bush..")
	inRange = false


