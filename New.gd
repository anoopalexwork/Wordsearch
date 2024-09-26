extends Label

# Called when the node enters the scene tree for the first time.
func _ready():
	var style_box = StyleBoxFlat.new()
	# Set the background color to red
	style_box.bg_color = Color(1, 0, 0, 1) # Red color
	# Apply the style box to the label
	#add_theme_stylebox_override("normal", style_box)
	
	
	
	#connect("", _on_label_mouse_entered)
	#connect("mouse_exited", self, "_on_label_mouse_exited")
	# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	
	if event is InputEventMouseButton and  event.is_pressed():
		#print(get_rect(),"----", get_global_mouse_position())
		if get_rect().has_point(get_global_mouse_position()):
			get_node("/root/Main/Puzzle").buildpuzz2(9,9,".")
			#var puzzleText = get_node("/root/Main/Puzzle").puzzleText
			get_node("/root/Main/gfxGrid").fillGrid()
			get_node("/root/Main/gfxGrid").savedRed = []
			#get_node("/root/Main/Puzzle").draw_grid(puzzleText)
			get_node("/root/Main/gfxGrid").queue_redraw()
			
		print("printing")	
		for x in range(0,-3,-1):
			print(x)
				
	
