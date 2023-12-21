extends Area2D

@export var itemInside : String = "noneset"
@export var itemQuantity : int

var item : Item

# label for item quantity
var lbl_quantity = null

@onready var spr = $FloorItemSprite
@onready var interactArea = $InteractArea


func _ready():
	
	if not item:
		item = ItemManager.get_item( itemInside )
	
	
	var newTexture = ResourceManager.sprites[itemInside]

	
	if(itemInside == "noneset"):
		newTexture = load("res://art/item_icon/bag.png")
		spr.texture = newTexture
	else:
		spr.texture = newTexture

	interactArea.interact_value = itemInside
	
	print("quantity:", item.quantity)
	


	
func set_quantity( value ):
	itemQuantity = value
		
	if itemQuantity > 1:
		
		print ("Dropped a multi quantity item")
		
		if lbl_quantity == null: # This is necessary to prevent creating extra labels
			lbl_quantity = Label.new()
			lbl_quantity.label_settings = load("res://font/quantity.tres")
			add_child( lbl_quantity )
			
		lbl_quantity.text = str( itemQuantity )
		lbl_quantity.visible = itemQuantity > 1
		lbl_quantity.scale = Vector2(0.2,0.2)



	
	
	
	
# on try to pick up
func interact():
	SignalManager.emit_signal( "item_picked", itemInside, null, itemQuantity)
	

# auto try to pick up the item if stepped over
func _on_body_entered(body: CharacterBody2D):
	if ("Player" in body.name):
		SignalManager.emit_signal( "item_picked", item, self, itemQuantity)

	
# on successful pickup, delete floor item
func item_picked():
	queue_free()

