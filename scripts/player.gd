extends CharacterBody2D

const WALK_SPEED = 65.0
const SPRINT_SPEED = 135.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector(
		"ui_left",
		"ui_right",
		"ui_up",
		"ui_down"
	)

	var moving := not direction.is_zero_approx()
	var sprinting := moving and Input.is_action_pressed("sprint")

	if direction.x < 0:
		sprite.flip_h = true
	elif direction.x > 0:
		sprite.flip_h = false

	var current_speed := SPRINT_SPEED if sprinting else WALK_SPEED
	velocity = direction * current_speed

	var animation_name: StringName = &"idle"
	if sprinting:
		animation_name = &"sprintanim"
	elif moving:
		animation_name = &"walkanim"

	if sprite.animation != animation_name:
		sprite.play(animation_name)

	move_and_slide()
