extends Node2D

@export var game_manager : GameManager
@export var spawnable_stats_array : Array[SpawnableStats] = []
@export var spawnable_pool : Array[Spawnable] = []
@onready var timer: Timer = $SpawnTimer

func _ready() -> void:
	for spawnable in spawnable_pool:
		game_manager.game_speed_changed.connect(spawnable.change_speed)

func _spawn():
	var spawnables = []
	for spawnable in spawnable_pool:
		if spawnable.active == false:
			spawnables.append(spawnable)
	
	if spawnables.is_empty():
		return
	var child = spawnables[0]
	child.assign_stats(spawnable_stats_array.pick_random())
	child.activate()
