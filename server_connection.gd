extends Node

var _score_callback = JavaScriptBridge.create_callback(_on_score_send)
@onready var _javascript_interface : JavaScriptObject

func _ready() -> void:
	_javascript_interface = JavaScriptBridge.get_interface("window")

func _on_score_send(args):
	pass
	
func send_score(score: int):
	#_javascript_interface.submitScore(score).then(_score_callback)
	pass
