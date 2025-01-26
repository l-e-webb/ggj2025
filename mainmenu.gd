extends Node2D

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://game_scene.tscn")

func _on_credits_button_pressed() -> void:
	$CreditsPanel.visible = true

func _on_thank_you_button_pressed() -> void:
	$CreditsPanel.visible = false
