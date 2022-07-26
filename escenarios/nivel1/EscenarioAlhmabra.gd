extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var mustafs=5

# Called when the node enters the scene tree for the first time.
func _ready():
	var objetos=$YSort
	
	for objeto in objetos.get_children():
		
		if "mustaf" in objeto.name:
			mustafs=mustafs+1
			
			objeto.connect("muerte", self, "muerte")

func muerte():
	mustafs=mustafs-1
	
	print("Ouch!!")
	
	if mustafs<=0:
		print("terminado")
		
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
