extends AnimatableBody2D

var velocity: Vector2 = Vector2(0,0)
var t: float = 0
var is_floating = false
var is_pop_timer_set = false

func _physics_process(delta: float) -> void:
	if is_floating:
		if not is_pop_timer_set:
			set_pop_timer()
		
		var freq = Constants.PLAIN_BUBBLE_DRIFT_FREQUENCY
		var amp = Constants.PLAIN_BUBBLE_DRIFT_AMPLITUDE
		t += delta
		t = fmod(t, TAU/freq)
		velocity.x = cos(t * freq) * amp
		
		velocity.y = maxf(
			velocity.y - Constants.PLAIN_BUBBLE_RISE_ACCEL * delta,
			-Constants.PLAIN_BUBBLE_RISE_MAX_SPEED
		)

		move_and_collide(velocity)

func set_pop_timer():
	get_tree().create_timer(
		Constants.MAX_BUBBLE_DURATION,
		true,
		true,
	).timeout.connect(pop)

func pop():
	SignalBus.bubble_pop.emit(global_position)
	queue_free()

func boundary_collision():
	pop()
	
