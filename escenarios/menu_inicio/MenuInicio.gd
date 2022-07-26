extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ButtonEmpezar_pressed():
	get_tree().change_scene("res://escenarios/nivel1/EscenarioAlhmabra.tscn")


func _on_ButtonCreditos_pressed():
	get_tree().change_scene("res://escenarios/menu_creditos/dummy2.tscn")


func _on_ButtonSalir_pressed():
	get_tree().quit()


func _on_ButtonEmpezar2_pressed():
	get_tree().change_scene("res://escenarios/instrucciones/instrucciones.tscn")
