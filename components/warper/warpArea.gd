extends Node2D


signal warp_area_entered(destination)

var entered = false
var emitted = false
@export var destination: String
@export var destID: int

func _on_body_entered(body: CharacterBody2D):
	if (body.name == "PlayerCat"):
		body.warping = true
		entered = true

func _on_body_exited(body):
	entered = false


func _process(delta):
	if entered == true:
		if get_parent().get_parent().handling == false:
			if emitted == false:
				emitted = true
				emit_signal("warp_area_entered", destination, destID)
				print("emitted warp signal")


