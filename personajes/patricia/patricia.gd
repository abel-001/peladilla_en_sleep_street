extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var velocidad=100

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("walking",-1,2)

#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	
	if Input.is_action_pressed("ui_right"):
		move_and_slide(Vector2(velocidad,0),Vector2(0,1))
		$AnimationPlayer.play("walking",-1,2)
	elif Input.is_action_just_pressed("slap"):
		$AnimationPlayer.play("slapping",-1,3)
	else:
		if $AnimationPlayer.is_playing():
			pass
		else:
			$AnimationPlayer.stop()
