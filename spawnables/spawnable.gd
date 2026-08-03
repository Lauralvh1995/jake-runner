extends CharacterBody2D
class_name Spawnable

@export var spawnable_stats : SpawnableStats

@export var score_bonus : int
@export var energy : int
@export var obstacle : bool

@export var obstacle_height : int
@export var active : bool = false
@export var movement_speed : float
@export var actual_speed : float
@export var y_offset : float
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
var base_height : float = 64.0

func assign_stats(stats : SpawnableStats) -> void:
	spawnable_stats = stats
	score_bonus = spawnable_stats.score_bonus
	energy = spawnable_stats.energy
	obstacle = spawnable_stats.obstacle
	movement_speed = spawnable_stats.movement_speed
	y_offset = stats.y_offset
	obstacle_height = stats.obstacle_height
	animated_sprite_2d.sprite_frames = spawnable_stats.sprite
	animated_sprite_2d.play("walk")
	collision_shape_2d.shape.get_rect().size.y = base_height * obstacle_height

func change_speed(speed: float):
	actual_speed = movement_speed * speed
	animated_sprite_2d.speed_scale = speed

func _physics_process(delta: float) -> void:
	if active:
		velocity.x = -actual_speed
		move_and_slide()

func activate():
	active = true
	position.y = -spawnable_stats.y_offset

func deactivate():
	position.x = 0.0
	position.y = 0.0
	active = false

func game_over(score: int):
	velocity.x = 0
	active = false

func _on_hurtbox_area_entered(area: Area2D) -> void:
	deactivate()
