extends Control
@onready var energy_bar : TextureProgressBar = %Energy
@onready var hp_bar: TextureProgressBar = %HPHearts
@onready var score_label: Label = %ScoreLabel

@onready var current_speed_label: Label = %CurrentSpeedLabel
@onready var game_over_panel: Panel = %GameOverPanel
@onready var game_over_text: Label = %GameOverText
@onready var game_over_score_label: Label = %GameOverScoreLabel
@onready var send_score_button: Button = %SendScoreButton

var current_score : int

var score_string = "Score:\n\n%s"

func change_speed_label(text : String):
	current_speed_label.text = text

func show_game_over_screen(score : int):
	current_score = score
	game_over_score_label.text = score_string % str(current_score)
	game_over_panel.visible = true

func _on_send_score_button_pressed() -> void:
	ServerConnection.send_score((int)(current_score))
	SceneLoader.go_to_title()

func _on_player_hp_loss(current_hp: Variant, max_hp: Variant) -> void:
	hp_bar.value = current_hp * 100/max_hp


func _on_game_manager_update_game_score(score: int) -> void:
	score_label.text = "SCORE: %s" % score


func _on_game_manager_game_speed_changed(speed: float) -> void:
	current_speed_label.text = str(speed)


func _on_game_manager_energy_changed(energy_level: int) -> void:
	energy_bar.value = energy_level
