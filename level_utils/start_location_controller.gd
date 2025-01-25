extends Marker2D

func _ready() -> void:
	SignalBus.send_player_to_start.connect(set_player_to_here)
	call_deferred("set_player_to_here")

func set_player_to_here():
	SignalBus.set_player_position.emit(global_position)
