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
			objeto.connect("recoge_peladilla", self, "recoge_peladilla")
			
	mustafs=mustafs-1 # Quitar al protagonista.
	


	#Contamos cuántos personajes hay!
	#mustafs=(len(get_tree().get_nodes_in_group("personaje")))-1

func muerte(quien):
	mustafs=mustafs-1
	
	print("Ouch!! ("+str(mustafs)+")")
	
	if quien.es_robot:
	
		if mustafs<=0:
			print("****************terminado")
			$Camera2D/gui/Timer.start(5)
			$Camera2D/gui/fin.visible=true
		
	else:
			$Camera2D/gui/Timer.start(5)
			$Camera2D/gui/perdiste.visible=true				
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://escenarios/menu_creditos/dummy2.tscn")


func _on_Timer_timeout():
	get_tree().change_scene("res://escenarios/menu_creditos/dummy2.tscn")

func recoge_peladilla():
	$Camera2D/gui.recoger_peladilla()
