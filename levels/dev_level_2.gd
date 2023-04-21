extends Node2D

@export var node_path = NodePath(".")

func _ready():
	node_path = get_node(".")
	
func genesis():
	print ("Dev Island Genesis Activating..")
