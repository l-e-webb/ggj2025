extends Node2D


var bubble_radius = 0.1
var bubble = null
const PLAIN_BUBBLE = preload("res://bubbles/PlainBubble.tscn")
@export var scale_factor = 0.1

# movement
func _process(delta: float) -> void:
	
	var mouse_x = get_viewport().get_mouse_position().x
	
	position.x = mouse_x
	
	if bubble != null and bubble.scale.x < Constants.MAX_BUBBLE_SCALE:
		bubble.scale += delta * scale_factor * Vector2(1, 1)
		print(bubble.scale)
	

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
	bubble.scale = Vector2(0.1, 0.1)
	
	
func release_bubble():
	bubble.is_floating = true
	var bubble_global_pos = bubble.global_position
	remove_child(bubble)
	
	get_tree().root.add_child(bubble)
	bubble.global_position = bubble_global_pos
	
	bubble = null
	

# stretch: change bubble type

# strech: stop the wand from going offscreen
