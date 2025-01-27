extends Marker2D

func _ready() -> void:
	SignalBus.send_player_to_start.connect(_on_send_player_to_start)

func _on_send_player_to_start():
	SignalBus.set_player_position.emit(global_position)
