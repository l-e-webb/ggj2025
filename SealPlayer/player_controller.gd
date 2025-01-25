extends CharacterBody2D

var time_since_last_jump_command = 10000. # just a big number
var time_since_on_floor = 10000. # just a big number
var has_air_jump = false

func _ready():
	SignalBus.set_player_position.connect(_on_set_player_position)

func _physics_process(delta: float) -> void:
	if is_on_floor():
		time_since_on_floor = 0.
	else:
		time_since_on_floor += delta
	
	if Input.is_action_just_pressed("ui_accept"):
		time_since_last_jump_command = 0.
	else:
		time_since_last_jump_command += delta
	
	# Add the gravity.
	velocity += get_gravity() * delta

	handle_jump()
	handle_horizontal_motion()

	move_and_slide()

func handle_jump():
	if time_since_last_jump_command > Constants.PLAYER_JUMP_BUFFER_TIME:
		# The player has not hit jump recently
		
		return

	# Commence jumping
	if time_since_on_floor < Constants.PLAYER_JUMP_BUFFER_TIME:
		# Floor jump
		velocity.y = -Constants.PLAYER_FLOOR_JUMP_VELOCITY
		has_air_jump = true
	elif has_air_jump and time_since_on_floor > Constants.MIN_TIME_BEFORE_SECOND_JUMP:
		# Air jump
		velocity.y = -Constants.PLAYER_AIR_JUMP_VELOCITY
		has_air_jump = false
	else:
		# Attempting to jump in the air with no air jump remaining, or too soon
		# after a ground jump
		pass

func handle_horizontal_motion():
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * Constants.PLAYER_HORIZONTAL_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, Constants.PLAYER_HORIZONTAL_SPEED)

func _on_set_player_position(pos: Vector2):
	global_position = pos

func boundary_collision():
	SignalBus.send_player_to_start.emit()
