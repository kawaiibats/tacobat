extends CharacterBody2D

@export var move_speed : float = 100 
@export var starting_direction : Vector2 = Vector2(0, 1)

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

@onready var all_interactions = []
@onready var interactLabel = $InteractionComponents/InteractLabel

@onready var alt_interactions = []
@onready var altInteractLabel = $InteractionComponents/AltInteractLabel


func _ready():
	update_animation_parameters(starting_direction)
	update_interactions()
	update_alt_interactions()




func _physics_process(_delta):
	
	
	# Get input direction
	
	# var input_direction = Vector2(
	# 	Input.get_action_strength("right") - Input.get_action_strength("left"),
	#	Input.get_action_strength("down") - Input.get_action_strength("up")
	# )

	update_animation_parameters(Input.get_vector("left","right","up","down").floor())
	
	
	# Update velocity
	velocity = Input.get_vector("left","right","up","down") * move_speed

	
	# Move and slide function uses velocity of character body to move character on map
	move_and_slide()
	
	# Pick new state function determines which animation state is appropriate to use
	pick_new_state()
	
	if Input.is_action_just_pressed("interact"):
		execute_interaction()
		
	if Input.is_action_just_pressed("altInteract"):
		execute_alt_interaction()


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















# Interaction Methods 
# ///////////////////////////////////////////////////////////////////////////
func _on_interaction_area_area_entered(area):
	all_interactions.insert(0, area)
	update_interactions()

func _on_interaction_area_area_exited(area):
	all_interactions.erase(area)
	update_interactions()

func update_interactions():
	if all_interactions:
		interactLabel.text = all_interactions[0].interact_label
	else:
		interactLabel.text = ""

func execute_interaction():
	if all_interactions:
		var cur_interaction = all_interactions[0]
		match cur_interaction.interact_type:
			"print_text" : print(cur_interaction.interact_value)
			



# Alt Interaction (r click) Methods 
# ///////////////////////////////////////////////////////////////////////////
func _on_alt_interaction_area_area_entered(area):
	alt_interactions.insert(0, area)
	update_alt_interactions()

func _on_alt_interaction_area_area_exited(area):
	alt_interactions.erase(area)
	update_alt_interactions()

func update_alt_interactions():
	if alt_interactions:
		altInteractLabel.text = alt_interactions[0].alt_interact_label
	else:
		altInteractLabel.text = ""

func execute_alt_interaction():
	if alt_interactions:
		var cur_alt_interaction = alt_interactions[0]
		match cur_alt_interaction.alt_interact_type:
			"print_text" : print(cur_alt_interaction.alt_interact_value)
