extends Node2D


signal warp_area_entered(destination)

var entered = false
var emitted = false
@export var destination: String

func _on_body_entered(body: CharacterBody2D):
	if body.name == "PlayerCat":
		body.warping = true
		entered = true

func _on_body_exited(body):
	entered = false


func _process(delta):
	if entered == true:
		if emitted == false:
			emitted = true
			emit_signal("warp_area_entered", destination)
			print("emitted signal")


