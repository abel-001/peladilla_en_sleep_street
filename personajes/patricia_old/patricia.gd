extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal muerte()

export var velocidad=200
export var vida=100.0
export var maxvida=100.0
export var potencia=30.0


var muriendo=false

var flip=false
var escalalado_rango=20
var lejos
var cerca
var en_rango=null
var en_rango_lista=[]

export var es_robot=true
var recibiendo=false

var zasca=false
var derecha=true

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("idle",-1,2)
	$AnimationPlayer.advance(randf())
	
	
	#lejos=get_node("../alto_camino")
	#cerca=get_node("../bajo_camino")
	#escalalado_rango=cerca.position.y-lejos.position.y	
	
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	var velocidad_y=0
	var velocidad_x=0
	var guantazo=false
	
	var movido=false
	
	if not muriendo:
		if not es_robot:

			if not recibiendo:
				if Input.is_action_pressed("slap"):
					$AnimationPlayer.play("slapping",-1,4)
					guantazo=true
				elif Input.is_action_pressed("coger"):
					$AnimationPlayer.play("pickup",-1,4)
				else:
					if Input.is_action_pressed("ui_up"):
						velocidad_y=-velocidad
						movido=true
					elif Input.is_action_pressed("ui_down"):
						velocidad_y=velocidad	
						movido=true
						
					if Input.is_action_pressed("ui_right"):

						velocidad_x=velocidad
						movido=true
						
						if Input.is_action_just_pressed("ui_right") and derecha==false:
							global_scale.x=-abs(global_scale.y)
							# scale.x=abs(scale.x)
						derecha=true
						
					elif Input.is_action_pressed("ui_left"):
						
						velocidad_x=-velocidad
						movido=true
#						print("-> "+str(scale.x))
#						
						if Input.is_action_just_pressed("ui_left") and derecha==true:
							global_scale.x=-abs(global_scale.y)
							print(global_scale.x)
						
						derecha=false
			else:
				if $AnimationPlayer.is_playing():
					pass
				else:
					recibiendo=false
					
		if movido:		
			move_and_slide(Vector2(velocidad_x,velocidad_y),Vector2(0,1))
			var reverse=false
			var factor=1

# Ya no hacen falta: ya rota...
#			if velocidad_x<0:
#				reverse=true
#				factor=-1
			
			$AnimationPlayer.play("walking",-1,factor*4,reverse)	
		else:
			if ($AnimationPlayer.current_animation=="muriendo" or $AnimationPlayer.current_animation=="pickup" or $AnimationPlayer.current_animation=="receiving" or $AnimationPlayer.current_animation=="slapping") and $AnimationPlayer.is_playing():
				pass		
			else:
				if $AnimationPlayer.is_playing() and $AnimationPlayer.current_animation=="idle":
					pass
				else:
					$AnimationPlayer.play("idle")
					$AnimationPlayer.advance(randf())
		
	# Tamaño del sprite, según su distanica a alto y bajo_camino
	#var distancia=lejos.position.y-position.y	
	# scale=Vector2(distancia/escalalado_rango,distancia/escalalado_rango)

func pegar(quien):
	print(quien.name+" ha pegado a "+name)
	dolor()
	
func dolor():
	$AnimationPlayer.play("receiving",-1,3)
	recibiendo=true
	vida=vida-potencia
	
	$barra_de_vida.actualizar_vida(vida/maxvida)
	if vida<=0:
		muriendo=true
		$AnimationPlayer.play("dying",-1,2)
		$dormir.visible=true 
		emit_signal("muerte")
		
	print("Recibiendo!")

func _on_guantada_body_entered(body):
	en_rango=body  # cambiar a colección!!!!!
	en_rango_lista.append(body)
	

func _zasca_on():
	zasca=true
	if en_rango ==null:
		pass
	else:
		for personaje in en_rango_lista:
			if personaje.is_in_group("personaje"):
				personaje.pegar(self)	
					
#			if en_rango.is_in_group("personaje"):
#				en_rango.pegar(self)
	
func _zasca_off():
	zasca=false

func _on_guantada_body_exited(body):
	en_rango=null #Mejor quitarlo de una lista!!!!
	en_rango_lista.erase(body)

func _on_guantada_area_entered(area):
	# Puede que sean áreas de otro tipo: fin de escenario, área de guantazo del enemigo...
	if area.is_in_group("sensible"):
		var body=area.get_parent()
		_on_guantada_body_entered(body)
	


func _on_guantada_area_exited(area):
	var body=area.get_parent()
	_on_guantada_body_exited(body)
