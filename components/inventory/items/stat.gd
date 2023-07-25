class_name Stat extends Resource

var stat
var value: int

func _init( data ):
	stat = Game_Enums.STAT[ data.stat ]
	value = data.value
	
	
