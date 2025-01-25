extends Node2D

const PLAIN_BUBBLE = preload("res://bubbles/PlainBubble.tscn")

var bubble = null

func _process(delta: float) -> void:
	# movement
	var mouse_x = get_viewport().get_mouse_position().x
	position.x = mouse_x
	
	if bubble != null and bubble.scale.x < Constants.MAX_BUBBLE_SCALE:
		bubble.scale += delta * Constants.BUBBLE_SCALE_SPEED_FACTOR * Vector2(1, 1)
	

# on click create bubble/on release finalize bubble
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("bubble_start"):
		blow_bubble()
	if event.is_action_released("bubble_start"):
		if bubble != null:
			release_bubble()
			print("bubble released")
		else:
			print("no bubble")
			
		
func blow_bubble():
	bubble = PLAIN_BUBBLE.instantiate()
	add_child(bubble)
	bubble.scale = Vector2(1, 1) * Constants.BUBBLE_MIN_SCALE
	
	
func release_bubble():
	bubble.is_floating = true
	var bubble_global_pos = bubble.global_position
	remove_child(bubble)
	
	get_tree().root.add_child(bubble)
	bubble.global_position = bubble_global_pos
	bubble = null
	

# stretch: change bubble type

# strech: stop the wand from going offscreen
