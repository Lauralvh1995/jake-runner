extends CharacterBody2D

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var label: Label = $Label

@export var max_hp : int = 5
@export var current_hp : int = 5

@export var jump_height : float = 300.0
@export var time_to_jump_apex: float = 0.2
@export var time_jump_descent: float = 0.2
@export var jump_end_modifier: float = 4.0

@onready var jump_velocity: float = ((2.0 * jump_height) / time_to_jump_apex) * -1.0
@onready var jump_gravity: float = ((-2.0 * jump_height) / pow(time_to_jump_apex, 2.0)) * -1.0
@onready var fall_gravity: float = ((2.0 * jump_height) / pow(time_jump_descent, 2.0))

var alive : bool = true

signal kill
signal hp_loss(current_hp, max_hp)
signal pickup(score: int, energy: int)

func change_animation_speed(speed: float):
	sprite_2d.speed_scale = speed

func _process(_delta: float) -> void:
	if alive:
		if  Input.is_action_just_pressed("jump") and is_on_floor():
			_jump()
	
		if Input.is_action_just_released("jump") and velocity.y < 0.0 and not is_on_floor():
			_end_jump()
		label.text = str(velocity.y)

func _physics_process(delta: float) -> void:
	if alive:
		_handle_gravity(delta)
		move_and_slide()

func _handle_gravity(delta : float):
	if not is_on_floor():
		if velocity.y <= 0.0:
			velocity.y += jump_gravity * delta
		else:
			velocity.y += fall_gravity * delta
	else:
		sprite_2d.play("walk")

func _jump():
	velocity.y = jump_velocity
	sprite_2d.play("jump")
	pass

func _end_jump():
	velocity.y = jump_velocity / jump_end_modifier

func hit_object(_body: Node2D):
	if _body.obstacle:
		kill_player()
	
	pickup.emit(_body.score_bonus, _body.energy)
	_body.deactivate()

func kill_player():
	current_hp -= 1
	hp_loss.emit(current_hp, max_hp)
	
	if current_hp <= 0:
		kill.emit()
		alive = false
		sprite_2d.play("dead")
