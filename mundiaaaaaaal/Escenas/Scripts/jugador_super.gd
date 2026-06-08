extends CharacterBody2D

@export var velocidad : float = 220.0
@export var vida_maxima : int = 100
@export var numero_jugador : int = 1
@export var danio_ataque : int = 15 

@export var porcentaje_reduccion : int = 20 

@export var arriba : String = "ar_a"
@export var abajo : String = "ab_a"
@export var izquierda : String = "izq_a"
@export var derecha : String = "der_a"
@export var atacar : String = "atacar_a"
@export var transformar : String = "transformar_a"

var vida : int = vida_maxima
var atacando : bool = false
var rival : CharacterBody2D = null

func _ready() -> void:
	if rival == null:
		for personj in get_tree().get_nodes_in_group("jugador"):
			if personj != self:
				rival = personj

func _physics_process(delta: float) -> void:
	if atacando:
		velocity = Vector2.ZERO
		move_and_slide()
		return
	
	var direccion := Vector2.ZERO
	direccion.x = Input.get_action_strength(derecha) - Input.get_action_strength(izquierda)
	direccion.y = Input.get_action_strength(abajo) - Input.get_action_strength(arriba)
	direccion = direccion.normalized()
	
	velocity = direccion * velocidad
	move_and_slide()
	flipear()
	animacion(direccion)
	
	if Input.is_action_just_pressed(atacar) and not atacando:
		iniciarAtaque()

func flipear() -> void:
	if rival != null and is_instance_valid(rival):
		$AnimatedSprite2D.flip_h = rival.global_position.x < global_position.x

func animacion(direccion: Vector2) -> void:
	if atacando:
		return
	if direccion != Vector2.ZERO:
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("idle")

func iniciarAtaque() -> void:
	atacando = true
	$AnimatedSprite2D.play("hit")
	
	if has_node("AttackZone"):
		var areas_golpeadas = $AttackZone.get_overlapping_areas()
		
		for area in areas_golpeadas:
			var cuerpo = area.get_parent() 
			if cuerpo != null and cuerpo.is_in_group("jugador") and cuerpo != self:
				cuerpo.recibirDanio(danio_ataque)
	else:
		print("Chequeá el nombre del nodo: Falta AttackZone en ", name)
			
	await $AnimatedSprite2D.animation_finished
	atacando = false

func recibirDanio(cantidad: int) -> void:
	var descuento = (cantidad * porcentaje_reduccion) / 100
	var danio_final = cantidad - descuento
	
	if danio_final < 0:
		danio_final = 0 
		
	vida -= danio_final
	
	if vida <= 0:
		morir()

func morir() -> void:
	queue_free()
