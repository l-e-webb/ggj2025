extends AudioStreamPlayer2D

var pop_sound = preload("res://sounds/pop.ogg")
var jump_sound = preload("res://sounds/jump.ogg")
var win_sound = preload("res://sounds/win.ogg")

func _ready() -> void:
	SignalBus.bubble_pop.connect(play_pop)
	SignalBus.seal_jump.connect(play_jump)
	SignalBus.player_win.connect(play_win)
	
	
func play_pop(pos: Vector2):
	var view_area = get_viewport_rect()
	if view_area.has_point(pos):
		self.stream = pop_sound
		self.play(.12)

func play_jump():
	self.stream = jump_sound 
	self.play(.05)

func play_win():
	self.stream = win_sound
	self.play()
