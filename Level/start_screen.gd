class_name StartScreen extends Control

signal start_the_game

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = true
	
func _process(_delta: float) -> void:
	if visible == true and Input.is_action_just_pressed("jump"):
		start_the_game.emit()
	
