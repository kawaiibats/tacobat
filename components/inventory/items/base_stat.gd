class_name Base_Stat extends Resource 

var stats = []

func _init( data ):
	
	for stat in data:
		stats.append( Stat.new( stat ) )
		

func get_lines():
	var lines =[]
	
	print("activated get_lines(), lines: ", lines)
	
	for stat in stats:
		
		print("this is stat: ", stat)
		
		print("rsz mngr stat info:", ResourceManager.stat_info)
		
		var stat_info = ResourceManager.stat_info[ stat.stat ]
		
		print("final stat_info: ", stat_info)
		
		var value = stat.value
		
		print("final stat_value: ", value)
		
		var text = stat_info.display.replace("#", str(value) )
		
		lines.append(text)
		
	return lines

	
	
