extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var maximo=100.0
var vida=maximo

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func actualizar_vida(vida_):
	vida=vida_
	scale.x=max(vida_,0)
	print("vida: "+str(scale.x))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
