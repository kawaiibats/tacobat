extends CharacterBody2D

@export var move_speed : float = 100 
@export var starting_direction : Vector2 = Vector2(0, 1)

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

@onready var all_interactions = []
@onready var interactLabel = $InteractionComponents/InteractLabel

@onready var alt_interactions = []
@onready var altInteractLabel = $InteractionComponents/AltInteractLabel

@export var health : float = 100
@onready var healthLabel = $InteractionComponents/HealthLabel


@onready var warping : bool = false


func _ready():
	update_animation_parameters(starting_direction)
	update_interactions()
	update_alt_interactions()
	
	var healthString = str(health)
	healthLabel.text = healthString
	
	


func _physics_process(_delta):
	if !warping:
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










# Find closest node // Code by Magso https://godotengine.org/qa/89680/how-get-the-node-closest-to-my-position
func find_closest_or_furthest(node: Object, group_name: String, get_closest:= true) -> Object:
	var target_group = get_tree().get_nodes_in_group(group_name)
	var distance_away = node.global_position.distance_to(target_group[0].global_position)
	var return_node = target_group[0]
	for index in target_group.size():
		var distance = node.global_position.distance_to(target_group[index].global_position)
		if get_closest == true && distance < distance_away:
			distance_away = distance
			return_node = target_group[index]
		elif get_closest == false && distance > distance_away:
			distance_away = distance
			return_node = target_group[index]
	return return_node











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
			"forage" : 
				print("Executing forage")
				
				var forageParent = cur_interaction.get_owner()
				
				print("You found.. ", forageParent.itemInside)
			
				forageParent.queue_free()
			



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
		
		var selectedInteraction
		for interaction in alt_interactions:
			if interaction.clickedOn == true:
				selectedInteraction = interaction
		
		if (selectedInteraction):
			print(selectedInteraction)
			match selectedInteraction.alt_interact_type:
				"print_text" : print(selectedInteraction.alt_interact_value)


