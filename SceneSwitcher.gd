extends Node

var next_level = null
var handling : bool = false



# set default level
@onready var current_level = $lvl0
# reference fade out animation
@onready var anim = $AnimationPlayer




func _ready() -> void:
	current_level.level_changed.connect(self.handle_level_changed)
	
	
func handle_level_changed(destination_name: String):
	if not handling:
		handling = true
		print("start handle_level_changed")

		next_level = load("res://levels/" + destination_name + ".tscn").instantiate()
		next_level.visible = false
		add_child(next_level)
		anim.play("fade_in")
		next_level.level_changed.connect(self.handle_level_changed)


func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"fade_in":
			print("cleanup1")
			current_level.cleanup()
			print("doesitgethere")
			current_level = next_level
			current_level.visible = true
			next_level = null
			anim.play("fade_out")
		"fade_out":
			print("reset transition cooldown")
			current_level.play_loaded_sound()
			var body = $PlayerCat
			handling = false
