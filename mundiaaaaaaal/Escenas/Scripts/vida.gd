extends CanvasLayer

@onready var barra_p1 = $Player1_container/ProgressBar
@onready var barra_p2 = $Player2_container/ProgressBar

func _process(delta: float) -> void:
	for jugador in get_tree().get_nodes_in_group("jugador"):
		if not is_instance_valid(jugador):
			continue
		if jugador.numero_jugador == 1:
			barra_p1.max_value = jugador.vida_maxima
			barra_p1.value = jugador.vida
		elif jugador.numero_jugador == 2:
			barra_p2.max_value = jugador.vida_maxima
			barra_p2.value = jugador.vida
