extends Node2D


signal warp_area_entered(destination)

var entered = false
@export var destination: String

func _on_body_entered(body: CharacterBody2D):
	entered = true

func _on_body_exited(body):
	entered = false


func _process(delta):
	if entered == true:
		emit_signal("warp_area_entered", destination)
		print("emitted signal")

