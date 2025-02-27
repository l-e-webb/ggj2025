extends CharacterBody2D

var time_since_last_jump_command = 10000. # just a big number
var time_since_on_floor = 10000. # just a big number
var time_on_floor = 10000. # just a big number
var has_air_jump = false
var gum_bubble = null

@export var in_end_dance = false
@export var in_level_end_dance = false

var desired_animation = StringName("Idle")

func _ready():
	SignalBus.player_win.connect(_on_player_win)
	SignalBus.set_player_position.connect(_on_set_player_position)
	SignalBus.despawn_player.connect(_on_despawn_player)
	
func _process(delta: float):
	
	if in_end_dance:
		desired_animation = StringName("DanceEnd")
	elif in_level_end_dance:
		desired_animation = StringName("DanceLevelEnd")
	elif gum_bubble != null:
		desired_animation = StringName("OnBubble")
	elif is_on_floor():
		if time_on_floor < 0.25:
			desired_animation = StringName("JumpLand")
		elif velocity.x == 0:
			desired_animation = StringName("Idle")
		else:
			desired_animation = StringName("Run")
	else:
		# In air
		if velocity.y < 1:
			desired_animation = StringName("JumpUp")
		else:
			desired_animation = StringName("JumpDown")
			
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
		
	if $AnimatedSprite2D.animation != desired_animation:
		$AnimatedSprite2D.play(desired_animation)

func _physics_process(delta: float) -> void:
	if in_end_dance:
		return
	
	if gum_bubble != null:
		handle_bubble_controls(delta)
		return
		
	if is_on_floor():
		time_since_on_floor = 0.
		time_on_floor += delta
	else:
		time_on_floor = 0
		time_since_on_floor += delta
	
	if Input.is_action_just_pressed("ui_accept"):
		time_since_last_jump_command = 0.
	else:
		time_since_last_jump_command += delta
	
	# Add the gravity.
	velocity += get_gravity() * delta

	if !in_level_end_dance:
		handle_jump()
	handle_horizontal_motion()
	move_and_slide()
	
	# If the player has penetrated deep into something, send to start
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_depth() > 12.5:
			SignalBus.player_die.emit()
		


func handle_jump():
	if time_since_last_jump_command > Constants.PLAYER_JUMP_BUFFER_TIME:
		# The player has not hit jump recently
		return

	if gum_bubble != null:
		jump_off_bubble()
	# Commence jumping
	elif time_since_on_floor < Constants.PLAYER_JUMP_BUFFER_TIME:
		# Floor jump
		velocity.y = -Constants.PLAYER_FLOOR_JUMP_VELOCITY
		has_air_jump = true
		SignalBus.seal_jump.emit()
	elif has_air_jump and time_since_on_floor > Constants.MIN_TIME_BEFORE_SECOND_JUMP:
		# Air jump
		velocity.y = -Constants.PLAYER_AIR_JUMP_VELOCITY
		has_air_jump = false
		SignalBus.seal_jump.emit()
	else:
		# Attempting to jump in the air with no air jump remaining, or too soon
		# after a ground jump
		pass

func handle_horizontal_motion():
	var direction = Input.get_axis("ui_left", "ui_right")
	if in_end_dance or in_level_end_dance:
		direction = 0 # hack
	if direction:
		velocity.x = direction * Constants.PLAYER_HORIZONTAL_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, Constants.PLAYER_HORIZONTAL_SPEED)

func boundary_collision():
	SignalBus.player_die.emit()
	
func handle_bubble_controls(delta: float):
	var direction = Input.get_axis("ui_left", "ui_right")
	rotate_bubble(direction, delta)
	
	if Input.is_action_just_pressed("ui_accept"):
		jump_off_bubble()
	
func stick_to_bubble(bubble: Node2D):
	if gum_bubble != null:
		return
	gum_bubble = bubble
	call_deferred("reparent", gum_bubble, true)
	
func rotate_bubble(direction: float, delta: float):
	gum_bubble.rotate(direction * delta * Constants.GUM_BUBBLE_ROTATION_SPEED)
	
func jump_off_bubble():
	reparent_to_game()
	
	# actually jump
	SignalBus.seal_jump.emit()
	if global_position.y <= gum_bubble.global_position.y + 50:
		velocity.y = -Constants.PLAYER_FLOOR_JUMP_VELOCITY
	else:
		velocity.y = 0
	time_since_last_jump_command = Constants.PLAYER_JUMP_BUFFER_TIME + 1 # Ensure we don't do an immediate air-jump
	has_air_jump = true

	gum_bubble.pop(false)
	gum_bubble = null

func _on_player_win():
	in_level_end_dance = true
	set_collision_mask_value(2, false) # Stop colliding with bubbles

func _on_set_player_position(pos: Vector2):
	global_position = pos
	velocity = Vector2()
	
	# Reset all state values we might have altered
	in_end_dance = false
	in_level_end_dance = false
	gum_bubble = null
	set_collision_mask_value(2, true)

func _on_despawn_player():
	queue_free()

func reparent_to_game():
	var contents_node = get_tree().root.find_child("GameContents", true, false)
	reparent(contents_node, true) # keep global transform
	rotation = 0. # don't keep rotation
