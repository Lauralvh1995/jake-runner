extends TextureRect

@onready var controls_panel: Panel = %ControlsPanel
@onready var high_scores_panel: Panel = %HighScoresPanel
@onready var game_world_scene: PackedScene = preload("res://World.tscn")

func StartGame():
	SceneLoader.go_to_game()

func ShowControls():
	if(!controls_panel.visible):
		controls_panel.visible = true
	else:
		controls_panel.visible = false
	pass
	
func CloseControls():
	controls_panel.visible = false
	pass

func ShowHighscores():
	if(!high_scores_panel.visible):
		high_scores_panel.visible = true
	else:
		high_scores_panel.visible = false
	pass

func CloseHighscores():
	high_scores_panel.visible = false
	pass
