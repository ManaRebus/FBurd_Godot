class_name PipePair extends Node2D

@export var pipe_speed := 200.0

func _physics_process(delta: float) -> void:
	position.x -= pipe_speed * delta
