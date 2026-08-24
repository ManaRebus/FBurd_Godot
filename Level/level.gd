extends Node2D

const PIPE_PAIR := preload("res://Pipes/pipe_pare.tscn")

@onready var background: TextureRect = %Background
@onready var ground: TextureRect = %Ground
@onready var pipe_timer: Timer = %PipeTimer
@onready var path_2d: Path2D = %Path2D
@onready var pipe_y_spawn: PathFollow2D = %PipeYSpawn

@export var background_speed := 0.05
@export var ground_speed := 0.2
var background_offset := 0.0
var ground_offset := 0.0

func _ready() -> void:
	pipe_timer.timeout.connect(spawn_pipes)

func _process(delta: float) -> void:
	background_offset += background_speed * delta
	ground_offset += ground_speed * delta
	
	background.material.set_shader_parameter("offset", background_offset)
	ground.material.set_shader_parameter("offset", ground_offset)

func spawn_pipes() -> void:
	var viewport_size := get_viewport_rect().size
	var pipe_position := Vector2.ZERO
	pipe_position.x = viewport_size.x + 50
	pipe_y_spawn.progress_ratio = randf()
	pipe_position.y = pipe_y_spawn.position.y
	
	var pipes = PIPE_PAIR.instantiate()
	pipes.position = pipe_position
	add_child(pipes)
