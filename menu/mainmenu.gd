extends Node2D

func _ready() -> void:
	SignalBus.pause_game.connect(_on_pause_game)
	SignalBus.unpause_game.connect(_on_unpause_game)

func _on_play_button_pressed() -> void:
	$OpeningBg.visible = true
	await get_tree().create_timer(0.5).timeout
	$OpeningBg/SealDialogueLabel.visible = true
	await get_tree().create_timer(10).timeout
	go_to_game()

func _on_credits_button_pressed() -> void:
	$CreditsPanel.visible = true

func _on_thank_you_button_pressed() -> void:
	$CreditsPanel.visible = false

func _input(event: InputEvent) -> void:
	if $OpeningBg.visible:	
		if event.is_action_pressed("ui_accept") or event.is_action_pressed("bubble_start"):
			go_to_game()
	elif event.is_action_pressed("pause"):
		if get_tree().paused:
			SignalBus.unpause_game.emit()
		else:
			SignalBus.pause_game.emit()

func go_to_game():
	get_tree().change_scene_to_file("res://game_scene.tscn")

func _on_pause_game():
	get_tree().paused = true
	$MainMenuSettings.visible = true

func _on_unpause_game():
	get_tree().paused = false
	$MainMenuSettings.visible = false

func _on_pause_button_pressed():
	SignalBus.pause_game.emit()
