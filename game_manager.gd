extends Node
class_name GameManager

@export var energy_max : float = 100.0
@export var current_energy : float = 100.0

@export var max_game_speed : float = 2.0
@export var normal_game_speed : float = 1.0
@export var min_game_speed : float = 0.5
@export var speed_delta : float = 3
@export var master_scale : float = 1
@export var score_interval : int = 2

@export var parallax_bg_sprites : Array[ParallaxBG]

var current_game_speed : float = 1.0
var current_score : float = 0

var score_string = "Score: %s"

var game_playing = true
var regaining_energy = false

signal update_game_score(score: int)
signal game_speed_changed(speed: float)
signal game_is_over(score : int)
signal energy_changed(energy_level : int)

func _process(delta: float) -> void:
	if(game_playing):
		current_score = current_score + score_interval * delta
		update_game_score.emit( (int)(current_score))

func _physics_process(delta: float) -> void:
	_handle_speed(delta)
	_handle_energy(current_game_speed)

func _handle_speed(delta):
	if game_playing:
		var input = Input.get_axis("slow_down", "speed_up")
		
		if input > 0 && !regaining_energy:
			#speed up
			current_game_speed = lerp(current_game_speed, max_game_speed * master_scale, speed_delta * delta)
			if abs(current_game_speed - max_game_speed * master_scale) < 0.01:
				current_game_speed = max_game_speed * master_scale
			pass
		elif input < 0 || regaining_energy:
			#slow down
			current_game_speed = lerp(current_game_speed, min_game_speed * master_scale, speed_delta * delta)
			if abs(current_game_speed - min_game_speed * master_scale) < 0.01:
				current_game_speed = min_game_speed * master_scale
			pass
		else:
			#return to normal
			current_game_speed = lerp(current_game_speed, normal_game_speed * master_scale, speed_delta * delta)
			if abs(current_game_speed - normal_game_speed * master_scale) < 0.01:
				current_game_speed = normal_game_speed * master_scale
			pass
	else:
		current_game_speed = lerp(current_game_speed, 0.0, 10 * speed_delta * delta)
		if current_game_speed < 0.01:
			current_game_speed = 0
	game_speed_changed.emit(current_game_speed)
	for parallaxBG in parallax_bg_sprites:
		parallaxBG.change_speed(current_game_speed)

func game_over():
	game_playing = false
	game_is_over.emit((int)(current_score))
	
func _on_player_kill() -> void:
	game_over()

func _handle_energy(speed : float):
	if speed >= normal_game_speed * 1.5 * master_scale && !regaining_energy:
		current_energy -= 1
		pass
	if speed <= min_game_speed * master_scale || regaining_energy:
		current_energy += 1
		pass
	current_energy = clampi(current_energy, 0, 100)
	energy_changed.emit(current_energy)
	if current_energy <= 0:
		regaining_energy = true
	
	if current_energy >= 100:
		regaining_energy = false


func _on_player_pickup(score: int, energy: int) -> void:
	current_score += score
	current_energy += energy
