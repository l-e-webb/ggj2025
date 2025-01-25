extends AnimatableBody2D

var velocity: Vector2 = Vector2(0,0)
var t: float = 0
var is_floating = false
var is_pop_timer_set = false

var condition

func _physics_process(delta: float) -> void:
	if is_floating:
		if not is_pop_timer_set:
			set_pop_timer()
		
		var freq = Constants.GUM_BUBBLE_DRIFT_FREQUENCY
		var amp = Constants.GUM_BUBBLE_DRIFT_AMPLITUDE
		t += delta
		t = fmod(t, TAU/freq)
		velocity.x = cos(t * freq) * amp
		
		velocity.y = maxf(
			velocity.y - Constants.GUM_BUBBLE_RISE_ACCEL * delta,
			-Constants.GUM_BUBBLE_RISE_MAX_SPEED
		)

		var collision = move_and_collide(velocity)
		
		if collision != null:
			on_collision(collision.get_collider())

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
	
	
func on_collision(body: Node2D):
	print("gum bubble has collided")
	if body.has_method("stick_to_bubble"):
		var bubble_transform = get_tree().RemoteTransform2D.instantiate()
		bubble_transform.set_remote_note(body.get_path())
		body.stick_to_bubble()
	
