class_name Scale_Control extends Control

var uiScale : float



#this cannot be ready(), must be init()
func _init():
	SignalManager.ui_scale_changed.connect(self._on_ui_scale_changed)


func set_ui_scale( value ):
	uiScale = value
	scale = Vector2( uiScale, uiScale)


func _on_ui_scale_changed( value ):
	print("on_ui_scale_changed activated")
	set_ui_scale( value )
