extends Node2D

const NIGHT_COLOR = Color("#091d3a")
const DAY_COLOR = Color("FFFFFF")

const MINUTES_PER_DAY = 1440
const MINUTES_PER_HOUR = 60
const INGAME_TO_REAL_MINUTE_DURATION = (2 * PI) / MINUTES_PER_DAY

@export var INGAME_SPEED = 0.5
@export var INITIAL_HOUR = 12:
	set(h):
		INITIAL_HOUR = h
		time = INGAME_TO_REAL_MINUTE_DURATION * INITIAL_HOUR * MINUTES_PER_HOUR
		
signal time_tick(day:int, hour:int, minute:int)
signal phase_change(day:int)




@onready var gradient = load("res://ui/daynightcycle-gradient-texture.tres")

var sky_color = null





var time:float = 0.0
var past_minute:float = -1.0
var saved_day = 0
var completed_days = []
var day_pass = false


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
	
	var day = int(total_minutes / MINUTES_PER_DAY)
	
	var current_day_minutes = total_minutes % MINUTES_PER_DAY
	
	var hour = int(current_day_minutes / MINUTES_PER_HOUR)
	var minute = int(current_day_minutes % MINUTES_PER_HOUR)
	
	if past_minute != minute:
		past_minute = minute
		time_tick.emit(day, hour, minute)
		
	if clock: clock.set_time(time, day, hour, minute)
	
	
	
	if day > saved_day and day not in completed_days:
		
		saved_day = day
		completed_days.append(day)
		phase_change.emit(day)

	


func _on_phase_change(day):
	print("A new phase has passed!")
	
	print("passed day ", day)
	
	print("current completed days: ", completed_days)

	print("Here are the current visited levels: ", LevelManager.visited_levels)
	
	
	
	
	
	
