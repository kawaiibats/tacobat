extends Area2D

@export var itemInside : String = "noneset"
@export var itemQuantity : int

var item : Item

@onready var spr = $FloorItemSprite
@onready var interactArea = $InteractArea


func _ready():
	
	if not item:
		item = ItemManager.get_item( itemInside )
	
	
	var texture_name = itemInside
	print(texture_name)
	
	if(itemInside == "noneset"):
		var newTexture = load("res://art/item_icon/bag.png")
		spr.texture = newTexture
	else:
		var newTexture = load("res://art/item_icon/" + texture_name + ".png")
		spr.texture = newTexture

	interactArea.interact_value = itemInside
	
	
# on try to pick up
func interact():
	SignalManager.emit_signal( "item_picked", itemInside, null)
	

# auto try to pick up the item if stepped over
func _on_body_entered(body: CharacterBody2D):
	if ("Player" in body.name):
		SignalManager.emit_signal( "item_picked", item, self)

	
# on successful pickup, delete floor item
func item_picked():
	queue_free()

