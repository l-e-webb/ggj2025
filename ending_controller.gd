extends Control

var ready_to_leave = false

func _ready():
	call_deferred("get_ready_to_leave")
	
func get_ready_to_leave():
	await get_tree().create_timer(1).timeout
	ready_to_leave = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("bubble_start"):
		get_tree().change_scene_to_file("res://mainmenu.tscn")
