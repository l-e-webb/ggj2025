extends PanelContainer


func _ready() -> void:
	setup_popup_observer()
	%MusicButton.set_pressed_no_signal(!AudioServer.is_bus_mute(0))
	%SfxButton.set_pressed_no_signal(!AudioServer.is_bus_mute(1))
	if OS.get_name() == "Web":
		%Quit.visible = false

func setup_popup_observer():
	var level_select: MenuButton = %LevelSelect
	var popup_menu = level_select.get_popup()
	popup_menu.index_pressed.connect(_on_level_menu_item_selected)

func _on_level_menu_item_selected(index: int):
	SignalBus.unpause_game.emit()
	SignalBus.load_level.emit(index)

func _on_music_button_toggled(toggled_on: bool):
	print("Music button toggled: %s" % toggled_on)
	SignalBus.set_music_is_on.emit(toggled_on)

func _on_sfx_button_toggled(toggled_on: bool):
	print("SFX button toggled: %s" % toggled_on)
	SignalBus.set_sfx_is_on.emit(toggled_on)

func _on_resume_button_pressed():
	SignalBus.unpause_game.emit()

func _on_return_to_main_button_pressed():
	SignalBus.return_to_main.emit()

func _on_quit_game_button_pressed():
	get_tree().quit()
