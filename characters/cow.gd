extends CharacterBody2D

enum COW_STATE { IDLE, WALK }

@export var move_speed : float = 20
@export var idle_time : float = 5
@export var walk_time : float = 2

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var sprite = $Sprite2D
@onready var timer = $Timer

var move_direction : Vector2 = Vector2.ZERO
var current_state : COW_STATE =  COW_STATE.IDLE


func _ready():
	select_new_direction()
	pick_new_state()


func _physics_process(_delta):

	if(current_state == COW_STATE.WALK):
		velocity = move_direction * move_speed
		move_and_slide()
		
	

# Randomly generated direction
# can be -1, 0, or 1 for x and y
func select_new_direction():
	move_direction = Vector2(
		randi_range(-1,1),
		randi_range(-1,1)
	)

	if (move_direction) == Vector2(0,0):
		var tiebreak = randi_range(0,1)
		if (tiebreak == 0):
			move_direction = Vector2(1,0)
		else:
			move_direction = Vector2(0,1)
		
	
#Face the right direction when moving
	if (move_direction.x < 0):
		sprite.flip_h = true
	elif (move_direction.x > 0):
		sprite.flip_h = false


# Switches from walking to idling
func pick_new_state():
	if(current_state == COW_STATE.IDLE):
		state_machine.travel("walk_right")
		current_state = COW_STATE.WALK
		select_new_direction()
		timer.start(walk_time)
	elif(current_state == COW_STATE.WALK):
		state_machine.travel("idle_right")
		current_state = COW_STATE.IDLE
		timer.start(idle_time)
		
		
		


func _on_timer_timeout():
	pick_new_state()
