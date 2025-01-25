extends AnimatableBody2D

@export var rise_accel: float = 3
@export var rise_max_speed: float = 2

@export var bubble_drift_amplitude: float = 0.5
@export var bubble_drift_frequency: float = 1.5

var velocity: Vector2 = Vector2(0,0)
var t: float = 0
var is_floating = false

func _physics_process(delta: float) -> void:
	
	if is_floating:
		t += delta
		t = fmod(t, TAU/bubble_drift_frequency)
		velocity.x = cos(t * bubble_drift_frequency) * bubble_drift_amplitude
		velocity.y = maxf(velocity.y - rise_accel * delta, -rise_max_speed)

		var collision = move_and_collide(velocity)
		
		
func boundary_collision():
	queue_free()
	
	
