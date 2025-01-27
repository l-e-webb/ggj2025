extends AnimatableBody2D

func begin_floating():
	set_pop_timer()
	
	var rise_tween = get_tree().create_tween()
	rise_tween.bind_node(self)
	rise_tween.set_trans(Constants.PLAIN_BUBBLE_RISE_TRANS)
	rise_tween.set_ease(Constants.PLAIN_BUBBLE_RISE_EASE)
	rise_tween.tween_method(
		set_y,
		position.y,
		Constants.PLAIN_BUBBLE_RISE_TARGET,
		Constants.PLAIN_BUBBLE_RISE_DURATION
	)
	
	var left = position.x
	var right = left + Constants.PLAIN_BUBBLE_DRIFT_OFFSET
	var drift_tween = get_tree().create_tween()
	drift_tween.bind_node(self)
	drift_tween.set_trans(Constants.PLAIN_BUBBLE_DRIFT_TRANS)
	drift_tween.set_ease(Constants.PLAIN_BUBBLE_DRIFT_EASE)
	drift_tween.set_loops()
	drift_tween.tween_method(
		set_x,
		left,
		right,
		Constants.PLAIN_BUBBLE_DRIFT_DURATION
	)
	drift_tween.tween_method(
		set_x,
		right,
		left,
		Constants.PLAIN_BUBBLE_DRIFT_DURATION
	)

func set_x(x: float):
	position.x = x

func set_y(y: float):
	position.y = y

func set_pop_timer():
	get_tree().create_timer(
		Constants.MAX_BUBBLE_DURATION,
		false,
		true,
	).timeout.connect(pop)

func pop():
	SignalBus.bubble_pop.emit(global_position)
	queue_free()
	print("plain bubble has popped")

func boundary_collision():
	pop()

	
