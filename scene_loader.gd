extends Node


@onready var title_screen : PackedScene = preload("res://title.tscn")
@onready var game_scene : PackedScene = preload("res://World.tscn")

func go_to_game():
	get_tree().change_scene_to_packed(game_scene)

func go_to_title():
	get_tree().change_scene_to_packed(title_screen)
