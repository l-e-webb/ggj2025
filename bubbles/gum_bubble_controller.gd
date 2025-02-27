extends BubbleBase

func _ready() -> void:
	bubble_type = "GumBubble"
	# handle collisions with player
	$Area2D.body_entered.connect(on_bubble_stick)
	$Area2D.body_exited.connect(on_bubble_unstick)
	$Area2D.monitoring = false
	super._ready()

func on_release():
	super.on_release()
	$Area2D.monitoring = true
	
	var rise_tween = get_tree().create_tween()
	rise_tween.bind_node(self)
	rise_tween.set_trans(Constants.GUM_BUBBLE_RISE_TRANS)
	rise_tween.set_ease(Constants.GUM_BUBBLE_RISE_EASE)
	rise_tween.tween_method(
		set_y,
		position.y,
		Constants.GUM_BUBBLE_RISE_TARGET,
		Constants.GUM_BUBBLE_RISE_DURATION
	)
	
	var left = position.x
	var right = left + Constants.GUM_BUBBLE_DRIFT_OFFSET
	var drift_tween = get_tree().create_tween()
	drift_tween.bind_node(self)
	drift_tween.set_trans(Constants.GUM_BUBBLE_DRIFT_TRANS)
	drift_tween.set_ease(Constants.GUM_BUBBLE_DRIFT_EASE)
	drift_tween.set_loops()
	drift_tween.tween_method(
		set_x,
		left,
		right,
		Constants.GUM_BUBBLE_DRIFT_DURATION
	)
	drift_tween.tween_method(
		set_x,
		right,
		left,
		Constants.GUM_BUBBLE_DRIFT_DURATION
	)

func pop(request_childred_jump: bool = true):
	SignalBus.bubble_pop.emit(global_position)
	
	if request_childred_jump:
		for child in get_children():
			if child.has_method("jump_off_bubble"):
				child.jump_off_bubble()
	
	queue_free()
	print("gum bubble has popped")

func boundary_collision():
	call_deferred("pop")

func on_bubble_stick(body: Node2D):
	if body.has_method("stick_to_bubble"):
		print("sticking to bubble")
		body.stick_to_bubble(self)
	
	
func on_bubble_unstick(body: Node2D):
	print("body has exited")
	
func on_collision(body: Node2D):
	print("gum bubble has collided")
	if body.has_method("stick_to_bubble"):
		var bubble_transform = get_tree().RemoteTransform2D.instantiate()
		bubble_transform.set_remote_note(body.get_path())
		body.stick_to_bubble()
	
