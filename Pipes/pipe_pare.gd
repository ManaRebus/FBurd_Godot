class_name PipePair extends Node2D

@export var pipe_speed := 200.0
@export var gap_between_pipes := 80.0

@onready var lower_pipe: Area2D = %LowerPipe
@onready var upper_pipe: Area2D = %UpperPipe

func _ready() -> void:
	lower_pipe.position.y = gap_between_pipes / 2
	upper_pipe.position.y = - gap_between_pipes / 2

func _physics_process(delta: float) -> void:
	position.x -= pipe_speed * delta
