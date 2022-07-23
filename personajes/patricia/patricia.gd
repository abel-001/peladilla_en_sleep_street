extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var velocidad=100

var flip=false

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("idle",-1,2)

#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	var velocidad_y=0
	
	if Input.is_action_pressed("ui_up"):
		velocidad_y=-velocidad
	elif Input.is_action_pressed("ui_down"):
		velocidad_y=velocidad	
	
	if Input.is_action_pressed("ui_right"):
		move_and_slide(Vector2(velocidad,velocidad_y),Vector2(0,1))
		$AnimationPlayer.play("walking",-1,2)
		flip=false
	elif Input.is_action_pressed("ui_left"):
		move_and_slide(Vector2(-velocidad,velocidad_y),Vector2(0,1))
		$AnimationPlayer.play("walking2",-1,2)
		flip=true
	elif Input.is_action_pressed("slap"):
		$AnimationPlayer.play("slapping",-1,3)
	else:
		$AnimationPlayer.play("idle")
		
	$"Walking-patriciaBis".flip_h=flip
