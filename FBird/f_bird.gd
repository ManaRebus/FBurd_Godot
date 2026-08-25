class_name Bird extends CharacterBody2D

@export var fall_gravity := 900.0
@export var max_fall_speed := 2000.0
@export var jump_velocity := -300.0

@onready var sprite_2d: Sprite2D = %Sprite2D

func _physics_process(delta: float) -> void:
	velocity.y += fall_gravity * delta
	velocity.y = minf(velocity.y, max_fall_speed)
	move_and_slide()

	if Input.is_action_just_pressed("jump"):
		velocity.y = jump_velocity
