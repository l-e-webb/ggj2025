extends Control

func _ready():
	call_deferred("setup_signals")

func setup_signals():
	for button: Button in $HBoxContainer.get_children():
		button.pressed.connect(
			func(): 
				_on_button_pressed(button.text)
				button.release_focus()
		)

func _on_button_pressed(text: String):
	SignalBus.load_level.emit(text)
