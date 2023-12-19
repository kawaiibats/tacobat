class_name Base_Stat extends Resource 

var debug = false

var stats = []

func _init( data ):
	
	for stat in data:
		stats.append( Stat.new( stat ) )
		

func get_lines():
	var lines =[]
	
	if (debug): print("activated get_lines(), lines: ", lines)
	
	for stat in stats:
		
		if (debug): print("this is stat: ", stat)
		
		if (debug): print("rsz mngr stat info:", ResourceManager.stat_info)
		
		var stat_info = ResourceManager.stat_info[ stat.stat ]
		
		if (debug): print("final stat_info: ", stat_info)
		
		var value = stat.value
		
		if (debug): print("final stat_value: ", value)
		
		var text = stat_info.display.replace("#", str(value) )
		
		lines.append(text)
		
	return lines

	
	
