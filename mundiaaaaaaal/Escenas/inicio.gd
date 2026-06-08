extends Node2D

func _on_boton_controles_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/controles.tscn")
func _on_boton_salir_pressed() -> void:
	get_tree().quit()
func _on_boton_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/menu.tscn")
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
