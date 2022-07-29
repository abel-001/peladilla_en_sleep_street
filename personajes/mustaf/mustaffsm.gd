extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal muerte(quien)
signal recoge_peladilla()

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

var peladilla=null

enum Direction {DIRECTION_LEFT, DIRECTION_RIGHT}
var direccion=Direction.DIRECTION_RIGHT
enum State {STATE_IDLE, STATE_WALKING, STATE_DYING, STATE_HITTING, STATE_RECEIVING, STATE_PICKING}
var state=State.STATE_IDLE
enum Action {IDLE, WALKING, DYING, HITTING, RECEIVING, PICKING}
var action=Action.IDLE

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

	
	match state:
		State.STATE_IDLE, State.STATE_WALKING:	
			action=Action.IDLE

			if Input.is_action_pressed("slap"):
					$AnimationPlayer.play("slapping",-1,4)
					state=State.STATE_HITTING
					action=Action.HITTING
			elif Input.is_action_pressed("coger"):
					$AnimationPlayer.play("pickup",-1,4)
					state=State.STATE_PICKING
					action=Action.PICKING
			if Input.is_action_pressed("ui_up"):
						velocidad_y=-velocidad
						movido=true
			elif Input.is_action_pressed("ui_down"):
						velocidad_y=velocidad	
						movido=true
			if Input.is_action_pressed("ui_right"):
						if direccion==Direction.DIRECTION_LEFT:
							global_scale.x=-global_scale.x
						direccion=Direction.DIRECTION_RIGHT			
						velocidad_x=velocidad
						movido=true
			elif Input.is_action_pressed("ui_left"):
						if direccion==Direction.DIRECTION_RIGHT:
							global_scale.x=-global_scale.x
						direccion=Direction.DIRECTION_LEFT		
						velocidad_x=-velocidad
						movido=true
			
			if movido:
				move_and_slide(Vector2(velocidad_x,velocidad_y),Vector2(0,1))
				var reverse=false
				var factor=1
				state=State.STATE_WALKING
			
				$AnimationPlayer.play("walking",-1,factor*4,reverse)	
			else:
				if state!=State.STATE_IDLE and action==Action.IDLE:
					$AnimationPlayer.play("idle",-1,2)
					$AnimationPlayer.advance(randf())	
					state=State.STATE_IDLE			
		
	# Tamaño del sprite, según su distanica a alto y bajo_camino
	#var distancia=lejos.position.y-position.y	
	# scale=Vector2(distancia/escalalado_rango,distancia/escalalado_rango)

func recoger():
	if peladilla:
		vida=vida+peladilla.valor
		peladilla.destruir()
		peladilla=null
		emit_signal("recoge_peladilla")

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
		emit_signal("muerte",self)
		
	print("Recibiendo!")

func _on_guantada_body_entered(body):
	en_rango=body  # cambiar a colección!!!!!
	en_rango_lista.append(body)
	
	# para que se defienda el robot:
	if es_robot and not muriendo:
		if rand_range(0,100)>70:
			$AnimationPlayer.play("slapping",-1,4)

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


func _on_recogedor_area_entered(area):
	if area.is_in_group("bonus"):
		peladilla=area


func _on_recogedor_area_exited(area):
	peladilla=null


func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"slapping", "receiving","pickup":
			state=State.STATE_IDLE
			$AnimationPlayer.play("idle",-1,2)
			$AnimationPlayer.advance(randf())	
	print("Finished!!! "+anim_name)
