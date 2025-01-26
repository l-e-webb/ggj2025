extends CharacterBody2D

var time_since_last_jump_command = 10000. # just a big number
var time_since_on_floor = 10000. # just a big number
var has_air_jump = false
var gum_bubble = null

func _ready():
	SignalBus.set_player_position.connect(_on_set_player_position)

func _physics_process(delta: float) -> void:
	
	if gum_bubble != null:
		handle_bubble_controls(delta)
		return
		
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

	if gum_bubble != null:
		jump_off_bubble()
	# Commence jumping
	elif time_since_on_floor < Constants.PLAYER_JUMP_BUFFER_TIME:
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
	velocity = Vector2()

func boundary_collision():
	SignalBus.send_player_to_start.emit()
	
func handle_bubble_controls(delta: float):
	var direction = Input.get_axis("ui_left", "ui_right")
	rotate_bubble(direction, delta)
	
	if Input.is_action_just_pressed("ui_accept"):
		jump_off_bubble()
	
func stick_to_bubble(bubble: Node2D):
	if gum_bubble != null:
		return
	gum_bubble = bubble
	#set_collision_mask_value(2, false) # so seal doesn't collide with other bubbles
	
	var pos = global_position
	var size = global_scale
	self.get_parent().remove_child(self) 
	gum_bubble.add_child(self)
	global_position = pos
	global_scale = size
	
func rotate_bubble(direction: float, delta: float):
	gum_bubble.rotate(direction * delta * Constants.GUM_BUBBLE_ROTATION_SPEED)
	
func jump_off_bubble():
	
	var pos = global_position
	var size = global_scale
	var root_node = get_tree().root
	gum_bubble.remove_child(self)
	root_node.add_child(self)
	global_position = pos
	global_scale = size
	
	# actually jump
	if self.global_position.y <= gum_bubble.global_position.y:
		velocity.y = -Constants.PLAYER_FLOOR_JUMP_VELOCITY
	else:
		velocity.y = 0
	
	gum_bubble = null
