extends Node2D


var bubble_radius = 0.1

# movement
func _process(delta: float) -> void:
	
	var mouse_x = get_viewport().get_mouse_position().x
	
	position.x = mouse_x
	

# on click create bubble/on release finalize bubble
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("bubble_start"):
		blow_bubble()
	if event.is_action_released("bubble_start"):
		print("bubble released")
		bubble_radius = 0
		
func blow_bubble():
	while bubble_radius < Constants.MAX_BUBBLE_RADIUS:
		bubble_radius += 0.1
		print(bubble_radius)
	

# stretch: change bubble type

# strech: stop the wand from going offscreen
