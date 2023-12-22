class_name Clock extends Scale_Control

@export var lbl_time_path: NodePath
@onready var lbl_time = get_node( lbl_time_path ) 

@export var lbl_day_path: NodePath
@onready var lbl_day = get_node( lbl_day_path ) 

@export var lbl_hour_path: NodePath
@onready var lbl_hour = get_node( lbl_hour_path ) 

@export var lbl_min_path: NodePath
@onready var lbl_min = get_node( lbl_min_path ) 

func set_time(time: float, day: int, hour: int, minute: int) -> void:
	lbl_time.text = "Time: " + str(snapped(time, 0.0001))
	
	lbl_day.text = "Day: " + str(day + 1)
	
	lbl_hour.text = "Hour: " + str(_amfm_hour(hour))
	
	lbl_min.text = "Min: " + _minute(minute) + " " + _am_pm(hour)
	
	

	


func _amfm_hour(hour:int) -> String:
	if hour == 0:
		return str(12)
	if hour > 12:
		return str(hour - 12)
	return str(hour)


func _minute(minute:int) -> String:
	if minute < 10:
		return "0" + str(minute)
	return str(minute)


func _am_pm(hour:int) -> String:
	if hour < 12:
		return "am"
	else:
		return "pm"
