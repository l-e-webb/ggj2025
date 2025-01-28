class_name BubbleBase extends AnimatableBody2D

var bubble_type: String = "BaseBubble"

func _ready():
	SignalBus.load_level.connect(func(_index): pop())

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
	print("%s has popped" % bubble_type)

func boundary_collision():
	pop()

func on_release():
	set_pop_timer()
	# Switch from layer 6 to 2 so that bubbles are treated like a platform
	# Items in layer 6 will not move the player with them
	set_collision_layer_value(2, true)
	set_collision_layer_value(6, false)
