extends Node

var turno : int = 1

func _on_mbappe_pressed() -> void:
	elegir("res://Escenas/escenasBasicos/mbappe.tscn")

func _on_lamin_pressed() -> void:
	elegir("res://Escenas/escenasBasicos/lamine.tscn")

func _on_vandijk_pressed() -> void:
	elegir("res://Escenas/escenasBasicos/vandijk.tscn")

func _on_messi_pressed() -> void:
	elegir("res://Escenas/escenasBasicos/messias.tscn")

func _on_cristiano_pressed() -> void:
	elegir("res://Escenas/escenasBasicos/cristiano.tscn")

func elegir(ruta : String) -> void:
	if turno == 1:
		Seleccion.escena_p1 = ruta
		turno = 2
		$Sprite2D/LabelTurno.text = "                     JUGADOR P2 ELIGE"
	elif turno == 2:
		Seleccion.escena_p2 = ruta
		get_tree().change_scene_to_file("res://Escenas/arena.tscn")
