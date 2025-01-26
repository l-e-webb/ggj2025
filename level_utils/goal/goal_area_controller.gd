extends Area2D

func _ready() -> void:
	body_entered.connect(on_player_enter)

func on_player_enter(_body: Node2D):
	print("You win!")
	SignalBus.player_win.emit()
	$AnimatedSprite2D.animation = StringName("Win")
