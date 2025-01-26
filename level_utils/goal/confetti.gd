extends AnimatedSprite2D

func _ready() -> void:
	SignalBus.player_win.connect(_on_player_win)

func _on_player_win():
	play("burst")
