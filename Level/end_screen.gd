class_name EndScreen extends Control

@onready var score: Label = %Score

var score_num := 0
signal restart_game
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = false

func _process(delta: float) -> void:
	score.text = "Score: " + str(score_num)
	if visible == true and Input.is_action_just_pressed("restart"):
		restart_game.emit()
