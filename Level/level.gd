extends Node2D

@onready var background: TextureRect = %Background
@onready var ground: TextureRect = %Ground

@export var background_speed := 0.05
@export var ground_speed := 0.2
var background_offset := 0.0
var ground_offset := 0.0

func _process(delta: float) -> void:
	background_offset += background_speed * delta
	ground_offset += ground_speed * delta
	
	background.material.set_shader_parameter("offset", background_offset)
	ground.material.set_shader_parameter("offset", ground_offset)
