extends BubbleBase

func _ready() -> void:
	bubble_type = "ElevatorBubble"
	super._ready()

func on_release():
	super.on_release()
	
	var rise_tween = get_tree().create_tween()
	rise_tween.bind_node(self)
	rise_tween.set_trans(Constants.ELEVATOR_BUBBLE_RISE_TRANS)
	rise_tween.set_ease(Constants.ELEVATOR_BUBBLE_RISE_EASE)
	rise_tween.tween_method(
		set_y,
		position.y,
		Constants.ELEVATOR_BUBBLE_RISE_TARGET,
		Constants.ELEVATOR_BUBBLE_RISE_DURATION
	)
	rise_tween.set_trans(Constants.ELEVATOR_BUBBLE_DESCEND_TRANS)
	rise_tween.set_ease(Constants.ELEVATOR_BUBBLE_DESCEND_EASE)
	rise_tween.tween_method(
		set_y,
		Constants.ELEVATOR_BUBBLE_RISE_TARGET,
		Constants.ELEVATOR_BUBBLE_DESCEND_TARGET,
		Constants.ELEVATOR_BUBBLE_DESCEND_DURATION
	)
	
	var left = position.x
	var right = left + Constants.ELEVATOR_BUBBLE_DRIFT_OFFSET
	var drift_tween = get_tree().create_tween()
	drift_tween.bind_node(self)
	drift_tween.set_trans(Constants.ELEVATOR_BUBBLE_DRIFT_TRANS)
	drift_tween.set_ease(Constants.ELEVATOR_BUBBLE_DRIFT_EASE)
	drift_tween.set_loops()
	drift_tween.tween_method(
		set_x,
		left,
		right,
		Constants.ELEVATOR_BUBBLE_DRIFT_DURATION
	)
	drift_tween.tween_method(
		set_x,
		right,
		left,
		Constants.ELEVATOR_BUBBLE_DRIFT_DURATION
	)
