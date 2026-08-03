extends AnimatedSprite2D

@export var game_manager : GameManager

func _ready() -> void:
	game_manager.game_speed_changed.connect(change_speed)

func change_speed(speed: float):
	speed_scale = -speed
