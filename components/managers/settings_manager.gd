extends Node

var fullscreen
var scale

func _ready():
	scale = 1
	fullscreen = false

func set_fullscreen( value ):
	fullscreen = value
	if fullscreen == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func set_scale( value ):
	scale = value
	SignalManager.emit_signal("ui_scale_changed", value)

