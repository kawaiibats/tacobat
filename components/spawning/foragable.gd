extends StaticBody2D

@export var itemInside : String = "noneset"
@export var forageLocID : int = 0
@export var rarity : int = 0
@export var stoneCount : int = 0

@onready var spr = $ForageSprite

func _ready():
	
	var texture_name = itemInside
	print(texture_name)
	
	var newTexture = load("res://art/item_icon/" + texture_name + ".png")

	spr.texture = newTexture

func resetPosition():
	var zed = Vector2(0,0)
	self.position = zed
	print("RESET POSITION OF THIS FORAGY:", self.position)

func getRarity():
	return rarity

func getStones():
	return stoneCount

func interact():
	SignalManager.emit_signal( "item_picked", itemInside, null)
	
# on successful pickup, delete foragy
func item_picked():
	queue_free()


