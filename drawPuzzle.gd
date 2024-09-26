extends Control
const Block = preload("res://Block.gd")

var gg =[]
var numblocks
var bsize
var x
var y
var margin=2
var word =""
var lastndx = Vector2(-1,-1)
var lastb = null
var currb=null
var track=false
var wordstart
var wordend=null
var savedRed = []
var saving = false

# Called when the node enters the scene tree for the first time.
func _ready():
	numblocks = 9
	bsize = int(((get_window().size.x)*0.95)/numblocks)
	x=7
	y=int((get_window().size.x)*0.1)
	var posx=x
	var posy=y
	
	
	for i in range(numblocks):
		var row = []
		for j in range(numblocks):
			var b = Block.new(".")
			b.bsize = bsize
			b.x = posx
			b.y = posy
			posx+=b.bsize+margin
			add_child(b)
			row.append(b)
		posx=x
		posy=posy+bsize+margin
		gg.append(row)
	
	fillGrid()
	self.show()
	
	

func fillGrid():
	for i in range(numblocks):
		for j in range(numblocks):
			gg[i][j].text =get_node("/root/Main/Puzzle").puzzleText[i][j]
			gg[i][j].color = Color.WHITE
			gg[i][j].queue_redraw()
			
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _draw():
	pass

func getIndex(bx,by):
	if bx>= self.x and bx <= self.x+((bsize+margin)*numblocks) and by >= self.y and by<=self.y+((bsize+margin)*numblocks):
		bx-=self.x
		by-=self.y
	else:
		return null
	var ix = int((bx)/(bsize+margin))
	var iy = int((by)/(bsize+margin))
	
	if ix >=numblocks:
		ix=numblocks-1
	if iy>=numblocks:
		iy=numblocks-1
	#print("ix,iy ",ix,"-",iy)
	return Vector2(iy,ix)
	

func getWord(start,end):
	
	if start!=null and end !=null:
		var xdir
		var ydir
		var xlen = end.x - start.x
		var ylen = end.y - start.y
		if xlen < 0:
			xdir = -1
		else:
			xdir = 1
		if ylen < 0:
			ydir = -1
		else:
			ydir = 1
		var txt=""
		print(xlen,"-wordlen-",ylen)
		if ylen==0 and xlen==0:
			txt=gg[start.x][start.y].text
			return txt
		elif ylen!=0 and xlen!=0 and abs(xlen)==abs(ylen):
			for c in range(0,ylen+ydir,ydir):
				for d in range(0,xlen+xdir,xdir):
					if abs(c)==abs(d):
						txt+=gg[start.x+d][start.y+c].text
			print("got word ",txt)
			return txt
			
		elif ylen!=0:
			for c in range(0,ylen+ydir,ydir):
					txt+= gg[start.x][start.y+(c)].text
			print(txt)
			return txt
		elif xlen!=0:
			for c in range(0,xlen+xdir,xdir):
				txt+=gg[start.x+(c)][start.y].text
			print(txt)
			return txt
	else:
		return null
func isSaved(r,c):
	if Vector2(r,c) in savedRed:
		return true
	else:
		return false
		
func setBarColor(start,end,color):
	if start!=null and end!=null:
		var xdir
		var ydir
		var ylen
		var xlen
		xlen = end.x - start.x
		ylen = end.y - start.y
		
		#if xlen < 0:
			#xdir = -1
		#else:
			#xdir = 1
		#if ylen < 0:
			#ydir = -1
		#else:
			#ydir = 1
		xdir = sign(xlen)
		ydir = sign(ylen)
		print(xlen,"-",ylen)
		print("len-dirs",xlen,"-",ylen,"-",xdir,"-",ydir)
		if xlen==0 and ylen==0:
			if not isSaved(start.x,start.y):
				gg[start.x][start.y].setColor(color)
				if saving and not isSaved(start.x,start.y):
					savedRed.append(Vector2(start.x,start.y))
		elif xlen!=0 and ylen!=0 and abs(xlen)==abs(ylen):
			
			for c in range(0,(ylen+ydir),ydir):
				for d in range(0,(xlen+xdir),xdir):
					if abs(c)==abs(d):
							if not isSaved(start.x+d,start.y+c):
								gg[start.x+(d)][start.y+(c)].setColor(color)
							if saving and not isSaved(start.x+d,start.y+c):
								savedRed.append(Vector2(start.x+d,start.y+c))
		#else:
			#for c in range(0,ylen*ydir):
				#for d in range(0,xlen*xdir):
					#
						#gg[start.x+c][start.y+d].setColor(color)				
					#
					
		#elif ylen!=0 and xlen!=0 and abs(xlen)==abs(ylen):
			#for c in range(0,ylen+ydir,ydir):
				#for d in range(0,xlen+xdir,xdir):
					#if abs(c)==abs(d):
						#gg[start.x+(d)][start.y+(c)].setColor(color)
			#
		elif ylen!=0:
			for c in range(0,ylen+ydir,ydir):
					#rint("Stry ",start.y+c)
					if not isSaved(start.x,start.y+c):
						gg[start.x][start.y+(c)].setColor(color)
					if saving and not isSaved(start.x,start.y+c):
							savedRed.append(Vector2(start.x,start.y+c))
		elif xlen!=0:
			for c in range(0,xlen+xdir,xdir):
				if not isSaved(start.x+c,start.y):
					gg[start.x+(c)][start.y].setColor(color)
				if saving and not isSaved(start.x+c,start.y):
								savedRed.append(Vector2(start.x+c,start.y))
			
	
func _input(event):
	var tpos = event.position
	var mx = tpos.x
	var my = tpos.y
	#print("mx,my", mx,"-",my)
	var ndx = getIndex(mx,my)
	if ndx!=null:
		currb = gg[ndx.x][ndx.y]
		#print("currb ",currb)
	
	if event is InputEventMouseButton and event.is_pressed:
			if event.button_index==MOUSE_BUTTON_LEFT:
				#print("press")
				if wordstart==null and getIndex(mx,my)!=null:
					wordstart = getIndex(mx,my)
					wordend=getIndex(mx,my)
					setBarColor(wordstart,wordend,Color.RED)
					print("start ",wordstart)
					
				
				track=true
					
					
	if event is InputEventMouseMotion and track:
				tpos = event.position
				mx = tpos.x
				my = tpos.y
				ndx = getIndex(mx,my)
				
				setBarColor(wordstart,wordend,Color.WHITE)
				
				if wordstart==null and getIndex(mx,my)!=null:
					wordstart=getIndex(mx,my)
					wordend=getIndex(mx,my)
					track=true
				#
				#
				#if ndx:
				if getIndex(mx,my)!=null and track:
					wordend=getIndex(mx,my)
					setBarColor(wordstart,wordend,Color.RED)
				
				
				#setBarColor(wordstart,wordend,Color.RED)
				#print(ndx," ",tpos)
				#currb = gg[ndx.x][ndx.y]
				#currb.setColor(Color.RED)
		
	if event is InputEventMouseButton and event.is_released():
			if event.button_index==MOUSE_BUTTON_LEFT:
				#print("letgo")
				if getIndex(mx,my)!=null:
					wordend = getIndex(mx,my)
				print(wordstart,"->",wordend)
				#word=null
				word = getWord(wordstart,wordend)
				
				#print(get_node("/root/Main/Puzzle").foundwords)
				if word in get_node("/root/Main/Puzzle").foundwords:
					saving = true
					setBarColor(wordstart,wordend,Color.RED)
					saving = false
				else:
					
					setBarColor(wordstart,wordend,Color.WHITE)
					
				print("word:",word)
				wordstart=null
				wordend=null
				track=false	
		
	
				
	
func movegrid():
	for i in range(200):
		gg[8][0].y+=1
		
