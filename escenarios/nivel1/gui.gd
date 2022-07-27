extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var n_peladillas=0
var max_peladillas=0
var peladillas=[]

# Called when the node enters the scene tree for the first time.
func _ready():
	for peladilla in $peladillas.get_children():
		max_peladillas=max_peladillas+1
		peladillas.append(peladilla)		

func recoger_peladilla():
	n_peladillas=n_peladillas+1
	poner_peladilla(n_peladillas)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func poner_peladilla(n):
	var i=0
	
	for peladilla in peladillas:
		if i<n:
			peladilla.visible=true
		else:
			peladilla.visible=false
		i=i+1
		
			
