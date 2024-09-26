extends Node2D
enum DIR {HORIZ,VERT,DIAGU,DIAGD,RHORIZ,RVERT,RDIAGU,RDIAGD}
var word4
var word5
var word6
var word7
var word8
var allWords
var puzzleText
var freespots
var e
var l
var gg
var foundnum = 0
var foundwords = []


func showerr(s):
	l.text = l.text+s
	
# Function to load each line of a file into an array
func load_lines_into_array(path):
	var lines_array = []
	var file = FileAccess.open(path, FileAccess.READ)
	while not file.eof_reached():
		var line = file.get_line()
		lines_array.append(line.to_upper())
	file.close()
	return lines_array

#func copy_file_to_user_storage():
	#
	#var src_path = "res://word9s.txt"
	#var dest_path = "user://word9s.txt"
	#var content
	#showerr("Opening\n")
	#var f = FileAccess.open(src_path,FileAccess.READ)
	#if f:
		#showerr("Opened res\n")
	#else:
		#showerr("resopen fail"+error_string(FileAccess.get_open_error())+"\n")
		#
	#if f.get_error()==OK:
		#showerr("getting\n")
		#content = f.get_as_text()
		#showerr("gottext\n")
		#showerr("}"+content)
		#f.close()
	#else: 
		#showerr("open src failed:"+src_path)	
	#
	#f = FileAccess.open(dest_path,FileAccess.WRITE)
	#if f:
		#showerr("Opened dest\n")
	#else:
		#showerr("opendest fail")
	#showerr("saving:"+dest_path+"\n")
	#if f.get_error() == OK:
		#showerr("Storing\n")
		#f.store_string(content)
		#showerr(error_string(f.get_error())+"Stored\n")
		#f.close()
	#else:
		#showerr("open dest failed")
# Call this method in the _ready function if the file doesn't exist in user://
	
	
func readWords(path):
	var file = FileAccess.open(path, FileAccess.READ)
	if not file:
		showerr("user file failed\n")
	else:
		showerr("user file opened\n")
		
	showerr("Reading\n")
	showerr(error_string((file.get_error()))+"readWords\n")
	
	if file.get_error()==OK:
		showerr("Loading...\n")
		# Read the entire file
		var file_contents = file.get_as_text()
		
		showerr(error_string(file.get_error())+"Read\n")
		showerr(file_contents)
		print(file_contents)
		# Close the file
		file.close()
		
		# Display the file contents
	else:
		showerr("Failed open "+path)
		#print("Failed to open file:", path)
	
func _ready():
	allWords = []
	
	allWords.append([""])
	allWords.append([""])
	allWords.append([""])
	allWords.append([""])
	allWords.append([])
	allWords.append([""])
	allWords.append([""])
	allWords.append([""])
	allWords.append([""])
	
	#allWords[] = []
	#allWords[4] = []
	allWords[4] = load_lines_into_array("res://word5.txt")
	allWords[5] = load_lines_into_array("res://word6.txt")
	allWords[6] = load_lines_into_array("res://word7.txt")
	allWords[7] = load_lines_into_array("res://word8.txt")
	allWords[8] = load_lines_into_array("res://word9.txt")
	


	get_window().keep_title_visible = true
	
	#build_puzzle(11,11,".")
	#print_grid(puzzleText)
	buildpuzz2(9,9,".")
	print_grid(puzzleText)
	

func buildpuzz2(rows,cols,val):
	puzzleText=[]
	freespots=[]
	for i in range(rows):
		var row = []
		for j in range(cols):
			row.append(val)
			freespots.append(Vector2(i,j))
		puzzleText.append(row)
		
	foundnum = 0
	foundwords = []
		
	alltouch()
	#writeword("ANOOp",2,3,2,8)
	#writeword("alexs",2,3,7,3)
	#writeword("12345678901",2,3,12,13)
	#wordmatch("..RN")
	
	
	print_grid(puzzleText)
	
func removespot(i,j,list):
	print("Removing ",i,"-",j)
	var n = 0
	for d in list:		
		if Vector2(i,j) == d:
			list.remove_at(n)
			#list.erase(d)
			print(i," ",j," removed at ",n)
		n+=1
		
func findspot(i,j,list):
	for d in list:
		if Vector2(i,j) == d:
			return true
	return false

#func dirword(i,j,l,dir):
	#var dirwords=[]
	#var horiz = getword(i,j,i,i+l)

func alltouch():
	
	var numfound = 0
	var nspot
	var nx
	var ny
	var strends
	var valid
	var word

	randomize()
	freespots.shuffle()
	
	
	while numfound != 20:
		valid = false
		var pos = 0
		var dirwords = []
		var matchedstring
		strends =[]
		
		nspot = freespots[randi()%len(freespots)]
		nx = nspot.x
		ny= nspot.y	
		dirwords.append(getword(nspot.x,nspot.y,nspot.x-4,nspot.y+4)) # UpRight
		strends.append(Vector2(nspot.x-4,nspot.y+4))
		#dirwords.append(getword(nspot.x,nspot.y,nspot.x+4,nspot.y+4)) # DownRight
		#strends.append(Vector2(nspot.x+4,nspot.y+4))
		dirwords.append(getword(nspot.x,nspot.y,nspot.x-4,nspot.y-4)) # UpLeft
		strends.append(Vector2(nspot.x-4,nspot.y-4))
		#dirwords.append(getword(nspot.x,nspot.y,nspot.x+4,nspot.y-4)) # DownLeft
		#strends.append(Vector2(nspot.x+4,nspot.y-4))
		dirwords.append(getword(nspot.x,nspot.y,nspot.x,nspot.y+4)) #Right
		strends.append(Vector2(nspot.x,nspot.y+4))
		#dirwords.append(getword(nspot.x,nspot.y,nspot.x,nspot.y-4)) #Left
		#strends.append(Vector2(nspot.x,nspot.y-4))
		dirwords.append(getword(nspot.x,nspot.y,nspot.x+4,nspot.y)) #Down
		strends.append(Vector2(nspot.x+4,nspot.y))
		#dirwords.append(getword(nspot.x,nspot.y,nspot.x-4,nspot.y)) #Up
		#strends.append(Vector2(nspot.x-4,nspot.y))
		
		print(dirwords)
		print(nspot)
		print(strends)
		while matchedstring == null:
			randomize()
			
			
			for x in range(dirwords.size()):
				if dirwords[x] == null:
					pass
				if dirwords[x].length() == 4 and dirwords[x].count(".") != 0:
					valid = true
					word = dirwords[x]
					
					pos = x
					break
				else:
					dirwords[x] = null
				
			
			if not valid:
				removespot(nx,ny,freespots)
				break
			
			else:
				print("valid is ",word," at ",pos)
				matchedstring = wordmatch(word)
				
			if matchedstring == null:
				dirwords[pos] == null
				break
			else:
				print("found ",matchedstring)
			
				numfound+=1
				foundwords.append(matchedstring)
				print("writing from ",nspot.x,"-",nspot.y," to ",strends[pos].x,"-",strends[pos].y)
				writeword(matchedstring,nspot.x,nspot.y,strends[pos].x,strends[pos].y)
			#print_grid(puzzleText)
				
	print(foundwords)					
				
			

		
#func onetouch(grid):
	#var numfound  = 0
	#foundwords = []
	#var d
	#randomize()
	#freespots.shuffle()
	#
	#while numfound != 7:
		#
		#var nspot
		#var nstr
		#var nx
		#var ny
		#var valid = false
		#var matchedstring
		#d = HORIZONTAL
		#
		##var ustr = puzzstr(nspot.x,nspot.y,4,HORIZONTAL)
		##nstr = ustr[2]
		##nx = ustr[0]
		##ny=ustr[1]
		#while matchedstring == null:
			#randomize()
			#nspot = freespots[randi()%len(freespots)]
			#print(nspot.x," ",nspot.y)
			#var ustr = getword(nspot.x,nspot.y,nspot.x,nspot.y+4)
			#nx = nspot.x
			#ny = nspot.y
			#
			#if ny+4 >= puzzleText.size():
				#ny=ny-4
			#for m in range(4):
				#if findspot(nx,ny+m,freespots):
					#valid = true
				#else:
					#valid = false
					#break
					#
			#if not valid:
				#matchedstring=null
				#pass
			#else:
			##print(nx,"|",ny,"|",ustr)
				#matchedstring=randmatch(nx,ny,4,puzzleText)
		#
		#foundwords.append(matchedstring)
		#print("found",matchedstring)
		#numfound+=1
		#
		#for n in range(4):
				#puzzleText[nx][ny+n] = matchedstring[n]
				#removespot(nx,ny+n,freespots)
				#
		#
		#
	#print(freespots)		
	#print(foundwords)			
#func notouch(grid):
	#var numfound  = 0
	#foundwords = []
	#var d
	#randomize()
	#freespots.shuffle()
	#while numfound != 10:
		#var nspot = freespots[0]
		#var nstr
		#var nx
		#var ny
		#d = HORIZONTAL
		#
		#var ustr = puzzstr(nspot.x,nspot.y,4,HORIZONTAL)
		#nstr = ustr[2]
		#nx = ustr[0]
		#ny=ustr[1]
		##print(nx,"|",ny)
		#if nstr != "....":
			#ustr= puzzstr(nx,ny,4,VERTICAL)
			#nstr = ustr[2]
			#nx = ustr[0]
			#ny=ustr[1]
			#if nstr != "....":
				#for n in range(3):
					#removespot(nx,ny+n,freespots)
				#for n in range(2):
					#removespot(nx+1+n,ny+1,freespots)
				#randomize()
				#freespots.shuffle()
				#continue
			#else:
				#var aword = getrand(4)
				#foundwords.append(aword)
				#numfound=numfound+1
				#for n in range(4):
					#puzzleText[nx+n][ny] = aword[n]
					#removespot(nx+n,ny,freespots)
		#else:
			#var aword = getrand(4)
			#foundwords.append(aword)
			#numfound=numfound+1
			#for n in range(4):
				#puzzleText[nx][ny+n] = aword[n]
				#removespot(nx,ny+n,freespots)
				#
	#print(foundwords)
	#
#func getrand(len):
	#var listsize
	#match(len):
		#4:
			#listsize=1974
		#5:
			#listsize=3081
		#6:
			#listsize=4070
		#7:
			#listsize=4260
		#8:
			#listsize=3785
	#
	#randomize()
	#return allWords[len][randi() % listsize]
func wordmatch(word):
	var matchstr
	var matchlen
	var r = RegEx.new()
	
	r.compile(word)
	
	var matchlist = []
	print("Searhing for ", word.length(), " letter word ", word)
	for w in allWords[word.length()]:
		var m = r.search(w)
		if m:
			matchlist.append(m.get_string())
			#print("Matchlist ",matchlist)
	randomize()
	matchlen = len(matchlist)
	print("matchedlistlen is ", matchlen)
	if matchlen == 0:
		return null
	
	matchstr = matchlist[randi()%matchlen]
	print(matchstr)
	return matchstr
	
#func randmatch(i,j,l,grid):
	#var matchstr
	#var matchlen
	#var r = RegEx.new()
	#var pstr = puzzstr(i,j,l,VERTICAL)
	#
	#print("pstr",pstr)
	#
	#var rstr =pstr[2]
	#r.compile(rstr)
	#
	#var matchlist = []
	#print("Searhing word at ", Vector2(i,j)," len ",l, "for ",rstr)
	#for w in allWords[l]:
		#var m = r.search(w)
		#if m:
			#matchlist.append(m.get_string())
			##print("Matchlist ",matchlist)
	#randomize()
	#matchlen = len(matchlist)
	#print("matchedlistlen is ", matchlen)
	#if matchlen == 0:
		#return null
	#matchstr = matchlist[randi()%matchlen]
	#print(matchstr)
	#return matchstr
	#
#func puzzstr(i,j,len,dir):
	#var strline =""
	#match(dir):
		#HORIZONTAL:
			#if j+len >= puzzleText.size():
				#j = puzzleText.size()-len
			#for n in range(len):
				#strline = strline+puzzleText[i][j+n]
			#return [i,j,strline]
		#VERTICAL:
			#if i+len >= puzzleText.size():
				#i =puzzleText.size()-len
			#for n in range(len):
				#strline = strline+puzzleText[i+n][j]
			#return [i,j,strline]

				
			
func getword(i,j,k,l):
	#Get the strings of length l for all directions starting from i,j
	var strline = ""
	#if abs(k-i) != abs(l-j):
		#print("ERR")
		#return
	var xlen = abs(l - j)
	var ylen = abs(k - i)
	var xdir = sign(l-j)
	var ydir = sign(k-i)
	var r
	if xlen !=0 and ylen != 0:
		if xlen != ylen:
			print("ERR check strings")
			return null

	if xlen == 0:
		r = ylen
	elif ylen == 0:
		r = xlen
	else:
		r = xlen
	
		
	for n in range(0,r):
		#print(i+(n*ydir),"-",j+(n*xdir),"-",n,"-",r)
		if (i+(n*ydir)) < 0 or (i+(n*ydir)) >= puzzleText.size() or (j+(n*xdir)) < 0 or (j+(n*xdir)) >= puzzleText.size():
			break
		else:
			strline = strline+puzzleText[i+(n*ydir)][j+(n*xdir)]
	print(strline) #Horizontal
	return strline
	
func writeword(txt,i,j,k,l):
	#Get the strings of length l for all directions starting from i,j
	#if abs(k-i) != abs(l-j):
		#print("ERR")
		#return
	var xlen = abs(l - j)
	var ylen = abs(k - i)
	var xdir = sign(l-j)
	var ydir = sign(k-i)
	var r
	if xlen !=0 and ylen != 0:
		if xlen != ylen:
			print("ERR")
			return null

	if xlen == 0:
		r = ylen
	elif ylen == 0:
		r = xlen
	else:
		r = xlen
		if r < txt.length() or r > txt.length()+1:
			print("Fix string size ","r ",r,"Str ",txt.length())
			return null
	print("r ",r,"Str ",txt.length())
	if r < txt.length() or r > txt.length():
		print("Fix string size ","r ",r,"Str ",txt.length())
		return null
	for n in range(0,r):
		print(i+(n*ydir),"-",j+(n*xdir),"-",n,"-",r)
		if (i+(n*ydir)) < 0 or (i+(n*ydir)) >= puzzleText.size() or (j+(n*xdir)) < 0 or (j+(n*xdir)) >= puzzleText.size():
			break
		else:
			puzzleText[i+(n*ydir)][j+(n*xdir)]=txt[n]

		
		
	
			

#func placewords(words, grid):
	#const DIR = ["HORIZ","VERT","DIAGU","DIAGD","REVHORIZ","REVVERT","REVDIAGU","REVDIAGD"]
	#var allplaced = false
	#var rlen
	#var rlenmin = 4
	#var rlenmax = 8
	#var rr
	#var rc
	#
	##Grab a pattern from the incomplete puzzle
	#
	#while not allplaced:
		#randomize()
		#rlen = randi_range(rlenmin,rlenmax)
		#for w in words:
			#
			#var c = (len(w))
			#print("c is ",c)
			#randomize()
			#var i = randi() % (grid.size()-1)
			#var j = randi() % (grid.size()-1)
			#if (j+c) >= grid.size():
				#j = grid.size() - c
				#
			#var start = Vector2(i,j)
			#print(start)
			#for n in range(c):
				##print(start.x," ",start.y+n)
				#grid[start.x][start.y+n] = w[n]
#
		#allplaced=true


		
	
func print_grid(grid):
	var row = String()
	var r = grid.size()
	var c = grid[0].size()
	print(str(r)+","+str(c))
	
	for i in range(r):
		for j in range(c):
			row = row + grid[i][j]
		print(row)
		row=""
#func drawBlock():
	#var f = Control.new().get_theme_default_font()
	##var fsize= int((bsizex/32)*40)
	##var ssize =int(f.get_height(fsize))
#
#func draw_grid(grid):
	#var r = grid.size()
	#var c = grid[0].size()
	#var bsize = 60
#
	#for i in range(r):
		#for j in range(c):
			#drawBlock()

		
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	pass

func _draw():
	#draw_grid(puzzleText)
	pass
