extends Node

var fullscreen
var scale

func _ready():
	scale = 1
	fullscreen = false

func set_fullscreen( value ):
	fullscreen = value

func set_scale( value ):
	scale = value
	SignalManager.emit_signal("ui_scale_changed", value)

