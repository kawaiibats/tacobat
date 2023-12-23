extends Node2D

const NIGHT_COLOR = Color("#091d3a")
const DAY_COLOR = Color("FFFFFF")

const MINUTES_PER_DAY = 1440
const MINUTES_PER_HOUR = 60
const INGAME_TO_REAL_MINUTE_DURATION = (2 * PI) / MINUTES_PER_DAY

########

@export var INGAME_SPEED = 0.5
@export var INITIAL_HOUR = 8:
	set(h):
		INITIAL_HOUR = h
		time = INGAME_TO_REAL_MINUTE_DURATION * INITIAL_HOUR * MINUTES_PER_HOUR
		
signal time_tick(day:int, hour:int, minute:int)
signal phase_change(day:int)


var time:float = 0.0
var past_minute:float = -1.0
var last_completed_day = 0
var current_day = 1


var sky_color = null



@onready var gradient = load("res://ui/daynightcycle-gradient-texture.tres")

@onready var scene_switcher = get_tree().get_first_node_in_group("SceneSwitcher")

@export var clock_path:NodePath
@onready var clock = get_node(clock_path)

@export var sky_modulator_path:NodePath
@onready var sky_modulator = get_node(sky_modulator_path)



var debug = false





func _ready() -> void:
	time = INGAME_TO_REAL_MINUTE_DURATION * INITIAL_HOUR * MINUTES_PER_HOUR
	




func _process(delta):
	
	# update in game tick
	time += delta * INGAME_SPEED
	var value = (sin(time - PI / 2)+ 1.0 ) / 2.0
	sky_color = gradient.gradient.sample(value)

	# set sky tint
	if sky_modulator: sky_modulator.color = sky_color
	
	if debug: print("current sky colour: ", sky_color)
	if debug: print("current time: ", time)
	
	# update in game day, hour, min
	_recalculate_time()



func _recalculate_time() -> void:
	var total_minutes = int(time / INGAME_TO_REAL_MINUTE_DURATION)
	
	current_day = last_completed_day + 1
	
	var current_day_minutes = total_minutes % MINUTES_PER_DAY
	
	var day = int(total_minutes / MINUTES_PER_DAY)
	var hour = int(current_day_minutes / MINUTES_PER_HOUR)
	var minute = int(current_day_minutes % MINUTES_PER_HOUR)
	
	if past_minute != minute:
		past_minute = minute
		time_tick.emit(current_day, hour, minute)
		
	if clock: clock.set_time(time, current_day, hour, minute)
	
	if day >= 1:
		last_completed_day = current_day
		time = 0.0
		phase_change.emit()




func _on_phase_change():
	print("A new phase has passed!")
	
	print("finished day ", current_day)

	print("Here are the current visited levels: ", LevelManager.visited_levels)
	
	for level in LevelManager.visited_levels:
		print("iterating on: ", level)
		
		if LevelManager.current_level != level:
			
			print(level, " is not loaded in right now ")
		
			var levelFile = load("res://saves/" + level + ".tscn")
	
			var world = levelFile.instantiate()
		
			add_child(world)
		
			world.visible = false
			world.timemarch()
			world.cleanup()
		
		else:
			
			# # # ###
			
			print("scene_switcher: ", scene_switcher)
			
			print("scene_switcher children: ", scene_switcher.get_children())
			
			scene_switcher.get_child(2).timemarch()
			
			# FIX THIS WITH REFERENCE TO WHATEVER THE CURRENTLY RUNNING LEVEL IS !!!! ! .timemarch() ~~~~~~
	
	
	
