extends Button

@export var uiScale : float

func _on_pressed():
	print("button pressed, exporting: ", uiScale)
	SignalManager.emit_signal("ui_scale_changed", uiScale)
