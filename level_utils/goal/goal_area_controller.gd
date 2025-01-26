extends Area2D

func _ready() -> void:
	set_up_monitoring()

func on_player_enter(_body: Node2D):
	print("You win!")
	SignalBus.player_win.emit()
	$AnimatedSprite2D.play(StringName("Win"))

func set_up_monitoring():
	monitoring = false
	await get_tree().create_timer(1).timeout
	monitoring = true
	body_entered.connect(on_player_enter)
