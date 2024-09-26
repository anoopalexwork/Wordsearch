extends Control

var x
var y
var bsize
var color
var text
var textcolor
var f
var show
var mouseover


func _init(c):
	text = c
	f = Control.new().get_theme_default_font()
	show = true
	color = Color.WHITE
	textcolor = Color.BLACK
	mouse_filter = Control.MOUSE_FILTER_PASS
	
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	# Replace with function body.

func setpos(px,py):
	self.x =px
	self.y = py

func setsize(s):
	self.size = s
	
func setRect(rx,ry,size):
	self.x = rx
	self.y = ry
	self.size = size
	
func setColor(c):
	self.color = c
	queue_redraw()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _draw():
	draw_rect(Rect2(Vector2(x,y),Vector2(bsize,bsize)),color)
	draw_string(f, Vector2(x+10, y+(bsize*0.8)),text, HORIZONTAL_ALIGNMENT_CENTER, -1, 60, Color.BLACK)
	
#func redraw():
		#draw_rect(Rect2(Vector2(x,y),Vector2(bsize,bsize)),color)
		#draw_string(f, Vector2(x+10, y+(bsize*0.8)),text, HORIZONTAL_ALIGNMENT_CENTER, -1, 60, Color.BLACK)
		#queue_redraw()

func _input(_event):
	
	pass
