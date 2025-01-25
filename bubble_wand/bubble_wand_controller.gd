extends Node2D

const PLAIN_BUBBLE = preload("res://bubbles/PlainBubble.tscn")
const GUM_BUBBLE = preload("res://bubbles/GumBubble.tscn")

var bubble = null
var can_bubble = true
var all_bubble_types = ["plain", "gum"]
var bubble_type_index:int = 0

var wand_with_bubble = preload("res://bubble_wand/bubblewandwithbubble.png")
var wand_empty = preload("res://bubble_wand/bubblewand.png")

func _process(delta: float) -> void:
	# movement
	var mouse_x = get_viewport().get_mouse_position().x
	position.x = mouse_x
	
	if bubble != null and bubble.scale.x < Constants.MAX_BUBBLE_SCALE:
		bubble.scale += delta * Constants.BUBBLE_SCALE_SPEED_FACTOR * Vector2(1, 1)
	

# on click create bubble/on release finalize bubble
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("bubble_start"):
		blow_bubble(bubble_type_index)
	if event.is_action_released("bubble_start"):
		if bubble != null:
			release_bubble()
			print("bubble released")
		else:
			print("no bubble")
	
	if event.is_action_released("bubble_switch"):
		bubble_type_index = (bubble_type_index + 1) % all_bubble_types.size()
		print("switch bubble type: " + str(bubble_type_index))
		
			
		
func blow_bubble(index: int):
	print("blow_bubble says: " + str(can_bubble))
	if can_bubble:
		if index == 1:
			bubble = GUM_BUBBLE.instantiate()
		else:
			bubble = PLAIN_BUBBLE.instantiate()
		add_child(bubble)
		bubble.scale = Vector2(1, 1) * Constants.BUBBLE_MIN_SCALE
	
	
func release_bubble():
	bubble.is_floating = true
	var bubble_global_pos = bubble.global_position
	$Sprite2D.set_texture(wand_empty)
	remove_child(bubble)
	
	can_bubble = false
	print("release_bubble_pre_cooldown: " + str(can_bubble))
	cooldown()
	
	get_tree().root.add_child(bubble)
	bubble.global_position = bubble_global_pos
	bubble = null
	
func cooldown():
	print("cooldown start: " + str(can_bubble))
	get_tree().create_timer(
		Constants.BUBBLE_WAND_COOLDOWN,
		true,
		true,
	).timeout.connect(reload)
	
	
func reload():
	$Sprite2D.set_texture(wand_with_bubble)
	can_bubble = true
	print("reload: " + str(can_bubble))
	

# stretch: change bubble type

# strech: stop the wand from going offscreen
