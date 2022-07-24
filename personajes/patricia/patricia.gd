extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var velocidad=100

var flip=false
var escalalado_rango=20
var lejos
export var es_robot=true

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("idle",-1,2)
	lejos=get_node("../alto_camino")
	var cerca=get_node("../bajo_camino")
	escalalado_rango=cerca.position.y-lejos.position.y	
	
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	var velocidad_y=0
	var velocidad_x=0
	
	var movido=false
	
	if not es_robot:
		if Input.is_action_pressed("ui_up"):
			velocidad_y=-velocidad
			movido=true
		elif Input.is_action_pressed("ui_down"):
			velocidad_y=velocidad	
			movido=true
			
		if Input.is_action_pressed("ui_right"):
			velocidad_x=velocidad
			movido=true
			scale.x=abs(scale.x)
		elif Input.is_action_pressed("ui_left"):
			velocidad_x=-velocidad
			movido=true
			print("-> "+str(scale.x))
			if scale.x>0:
				scale.x=-scale.x
				print(scale.x)
			
	if movido:		
		move_and_slide(Vector2(velocidad_x,velocidad_y),Vector2(0,1))
		$AnimationPlayer.play("walking",-1,2)	
	elif Input.is_action_pressed("slap"):
		$AnimationPlayer.play("slapping",-1,4)
	else:
		if $AnimationPlayer.current_animation=="slapping" and $AnimationPlayer.is_playing():
			pass		
		else:
			$AnimationPlayer.play("idle")
			
	
	# Tamaño del sprite, según su distanica a alto y bajo_camino
	var distancia=lejos.position.y-position.y	
	# scale=Vector2(distancia/escalalado_rango,distancia/escalalado_rango)
