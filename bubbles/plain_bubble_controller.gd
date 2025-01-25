extends CharacterBody2D

@export var rise_accel: float = 3
@export var rise_max_speed: float = 2

@export var bubble_drift_amplitude: float = 0.5
@export var bubble_drift_frequency: float = 1.5

var t: float = 0

func _physics_process(delta: float) -> void:
	t += delta
	t = fmod(t, TAU/bubble_drift_frequency)
	velocity.x = cos(t * bubble_drift_frequency) * bubble_drift_amplitude
	velocity.y = maxf(velocity.y - rise_accel * delta, -rise_max_speed)

	move_and_collide(velocity)
