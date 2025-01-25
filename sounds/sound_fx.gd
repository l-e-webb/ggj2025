extends AudioStreamPlayer2D


func _ready() -> void:
	SignalBus.bubble_pop.connect(play_pop)
	
	
func play_pop(pos: Vector2):
	var view_area = get_viewport_rect()
	if view_area.has_point(pos):
		self.play(.12)
