extends Sprite2D
class_name ParallaxBG

@export var movement_speed : float = 150
@export var actual_speed : float = 150

func change_speed(speed: float):
	actual_speed = movement_speed * speed 

func _physics_process(delta: float) -> void:
	position.x = position.x - actual_speed / scale.x * delta
	if(position.x < -900.0):
		Reset()

func Reset():
	position.x = 1820.0

func game_over(score: int):
	actual_speed = 0
