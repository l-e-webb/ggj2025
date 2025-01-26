extends Node2D

func _on_play_button_pressed() -> void:
	$OpeningBg.visible = true
	await get_tree().create_timer(1).timeout
	$OpeningBg/SealDialogueLabel.visible = true
	await get_tree().create_timer(10).timeout
	go_to_game()

func _on_credits_button_pressed() -> void:
	$CreditsPanel.visible = true

func _on_thank_you_button_pressed() -> void:
	$CreditsPanel.visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("bubble_start"):
		if $OpeningBg.visible:
			go_to_game()

func go_to_game():
	get_tree().change_scene_to_file("res://game_scene.tscn")
