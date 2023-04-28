extends StaticBody2D

@export var itemInside : String = "noneset"
@export var forageLocID : int = 0
@export var rarity : int = 0

@onready var spr = $ForageSprite

func _ready():
	
	var texture_name = itemInside
	print(texture_name)
	
	var newTexture = load("res://art/forage/" + texture_name + ".png")

	spr.texture = newTexture
