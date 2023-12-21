# ItemDropArea.gd

extends Area2D

@export var player_node_path: NodePath
@onready var player = get_node(player_node_path)

var debug = false


func _input_event(viewport, event, x):
	
	if (event is InputEventMouseMotion):
		if debug: print ("DETECT mouse enter")
		
		player.canDropItems = true
