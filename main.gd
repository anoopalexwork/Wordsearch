extends Node
var word4
var word5
var word6
var word7
var word8
var allwords
var puzzleText


# Function to load each line of a file into an array
func load_lines_into_array(path):
	var lines_array = []
	var file = FileAccess.open(path, FileAccess.READ)
	while not file.eof_reached():
		var line = file.get_line()
		lines_array.append(line)
	file.close()
	return lines_array


# Called when the node enters the scene tree for the first time.
func _ready():
	allwords = []
	
	#word4 = load_lines_into_array("res://word5.txt")
	#word5 = load_lines_into_array("res://word6.txt")
	#word6 = load_lines_into_array("res://word7.txt")
	#word7 = load_lines_into_array("res://word8.txt")
	#word8 = load_lines_into_array("res://word9.txt")
	allwords.append([""])
	allwords.append([""])
	allwords.append([""])
	allwords.append([""])
	allwords.append([""])
	allwords.append([""])
	allwords.append([""])
	allwords.append([""])
	allwords.append([""])
	
	allwords = []
	allwords[4] = []
	allwords[4] = load_lines_into_array("res://word5.txt")
	allwords[5] = load_lines_into_array("res://word6.txt")
	allwords[6] = load_lines_into_array("res://word7.txt")
	allwords[7] = load_lines_into_array("res://word8.txt")
	allwords[8] = load_lines_into_array("res://word9s.txt")
	#word6 = load_lines_into_array("res://word7.txt")
	#word7 = load_lines_into_array("res://word8.txt")
	#word8 = load_lines_into_array("res://word9.txt")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
