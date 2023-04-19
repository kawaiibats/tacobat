extends CharacterBody2D

@export var move_speed : float = 100 
@export var starting_direction : Vector2 = Vector2(0, 1)

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")



func _ready():
	update_animation_parameters(starting_direction)




func _physics_process(_delta):
	
	
	# Get input direction
	
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)

	update_animation_parameters(input_direction)
	
	
	# Update velocity
	velocity = input_direction * move_speed
	
	
	# Move and slide function uses velocity of caracter body to move character on map
	move_and_slide()
	
	# Pick new state function determines which animation state is appropriate to use
	pick_new_state()


# Update direction of player
func update_animation_parameters(move_input : Vector2):
	# Don't change animation parameters if there is no move input
	if (move_input != Vector2.ZERO):
		animation_tree.set("parameters/walk/blend_position", move_input)
		animation_tree.set("parameters/idle/blend_position", move_input)
		
		
# Choose state based on what is happening with the player
func pick_new_state():
	if (velocity != Vector2.ZERO):
		state_machine.travel("walk")
	else:
		state_machine.travel("idle")


