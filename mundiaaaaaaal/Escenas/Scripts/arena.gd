extends Node2D

@export var pos_p1 : Vector2 = Vector2(200, 300)
@export var pos_p2 : Vector2 = Vector2(600, 300)

func _ready() -> void:
	var escena_p1 = load(Seleccion.escena_p1).instantiate()
	var escena_p2 = load(Seleccion.escena_p2).instantiate()
	
	escena_p1.numero_jugador = 1
	escena_p1.arriba = "ar_a"
	escena_p1.abajo = "ab_a"
	escena_p1.izquierda = "izq_a"
	escena_p1.derecha = "der_a"
	escena_p1.atacar = "atacar_a"
	escena_p1.transformar = "transformar_a"
	
	escena_p2.numero_jugador = 2
	escena_p2.arriba = "ar_b"
	escena_p2.abajo = "ab_b"
	escena_p2.izquierda = "izq_b"
	escena_p2.derecha = "der_b"
	escena_p2.atacar = "atacar_b"
	escena_p2.transformar = "transformar_b"
	
	add_child(escena_p1)
	add_child(escena_p2)
	
	escena_p1.global_position = pos_p1
	escena_p2.global_position = pos_p2
	
	escena_p1.add_to_group("jugador")
	escena_p2.add_to_group("jugador")
	
	escena_p1.rival = escena_p2
	escena_p2.rival = escena_p1
