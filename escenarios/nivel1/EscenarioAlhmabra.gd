extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var mustafs=0
var gui

# Called when the node enters the scene tree for the first time.
func _ready():
	var objetos=$YSort
	
	for objeto in objetos.get_children():

		if "mustaf" in objeto.name:
			mustafs=mustafs+1

			objeto.connect("muerte", self, "muerte")
	mustafs=mustafs-1 # Quitar al protagonista.
	


	#Contamos cuántos personajes hay!
	#mustafs=(len(get_tree().get_nodes_in_group("personaje")))-1

func muerte():
	mustafs=mustafs-1
	
	print("Ouch!! ("+str(mustafs)+")")
	
	if mustafs<=0:
		print("****************terminado")
		$YSort/mustaf/Camera2D/gui/Timer.start(5)
		$YSort/mustaf/Camera2D/gui/fin.visible=true
		
		
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	get_tree().change_scene("res://escenarios/menu_creditos/dummy2.tscn")
