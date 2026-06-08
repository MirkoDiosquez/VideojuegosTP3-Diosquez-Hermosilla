extends CharacterBody2D

@export var velocidad : float = 150.0
@export var vida_maxima : int = 100
@export var numero_jugador : int = 1
@export var arriba : String = "ar_a"
@export var abajo : String = "ab_a"
@export var izquierda : String = "izq_a"
@export var derecha : String = "der_a"
@export var atacar : String = "atacar_a"
@export var transformar : String = "transformar_a"

var vida : int = vida_maxima
var atacando : bool = false
var transformado : bool = false
var rival : CharacterBody2D = null

func _ready() -> void:
	vida = vida_maxima
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
	if Input.is_action_just_pressed(transformar) and not transformado:
		iniciarTransformacion()

func flipear() -> void:
	if rival != null:
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
	var posicion_original = global_position
	$AnimatedSprite2D.play("hit")
	if rival != null and is_instance_valid(rival):
		var distancia = global_position.distance_to(rival.global_position)
		if distancia < 80:
			rival.recibirDanio(10)
	await $AnimatedSprite2D.animation_finished
	global_position = posicion_original
	atacando = false

func iniciarTransformacion() -> void:
	atacando = true
	transformado = true
	$AnimatedSprite2D.play("damage")
	await $AnimatedSprite2D.animation_finished
	$AnimatedSprite2D.play("idle")
	atacando = false

func recibirDanio(cantidad: int) -> void:
	vida -= cantidad
	if vida <= 0:
		morir()

func morir() -> void:
	queue_free()
