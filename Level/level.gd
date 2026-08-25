extends Node2D

const PIPE_PAIR := preload("res://Pipes/pipe_pare.tscn")

@onready var bird: Bird = %FBird
@onready var background: TextureRect = %Background
@onready var ground: TextureRect = %Ground
@onready var pipe_y_spawn: PathFollow2D = %PipeYSpawn
@onready var score_label: Label = %Score
@onready var dead_zone: Area2D = %DeadZone

var score := 0
var pipe_array: Array = []
@export var spawn_interval := 2.0
var pipe_timer = create_timer()

@export_group("Background movement")
@export var background_speed := 0.05
@export var ground_speed := 0.2
var background_offset := 0.0
var ground_offset := 0.0


#creates timer for pipes to spawn
func create_timer() -> Timer:
	var _timer := Timer.new()
	_timer.autostart = true
	_timer.one_shot = false
	return _timer


func _ready() -> void:
	add_child(pipe_timer)
	pipe_timer.start(spawn_interval)
	pipe_timer.timeout.connect(spawn_pipes)
	
	dead_zone.body_entered.connect(func (body: Node2D) -> void:
		if body is Bird:
			game_over()
			)
	

# handels background a ground movement through shaders
func _process(delta: float) -> void:
	background_offset += background_speed * delta
	ground_offset += ground_speed * delta
	background.material.set_shader_parameter("offset", background_offset)
	ground.material.set_shader_parameter("offset", ground_offset)

func _physics_process(_delta: float) -> void:
	for pipe in pipe_array:
		if pipe.position.x < bird.position.x and pipe.scored == false:
			score += 1
			pipe.scored = true
			score_label.text = "Score: " + str(score)

# spawning pipe-pairs along x and y: x: outside of a screen; y: random position on a path2D
# adds pipe to the array and connects delete signal
# connects bird-pipe collision signal
func spawn_pipes() -> void:
	var viewport_size := get_viewport_rect().size
	var pipe_position := Vector2.ZERO
	pipe_position.x = viewport_size.x + 50
	pipe_y_spawn.progress_ratio = randf()
	pipe_position.y = pipe_y_spawn.position.y
	
	var pipes = PIPE_PAIR.instantiate()
	pipes.position = pipe_position

	add_child(pipes)
	pipe_array.append(pipes)
	
	pipes.pipe_deleted.connect(_on_pipe_deleted.bind(pipes))
	pipes.bird_collision.connect(game_over)

# erase pipe from array when signal on pipe free is emmited
func _on_pipe_deleted(pipes) -> void:
	pipe_array.erase(pipes)


func game_over() -> void:
	set_physics_process(false)
	get_tree().paused = true
	#get_tree().reload_current_scene()
