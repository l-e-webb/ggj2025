extends Node2D

@export var starting_level: String
var current_level = null

func _ready():
	SignalBus.load_level.connect(load_level)
	if starting_level:
		SignalBus.load_level.emit(starting_level)

func load_level(name: String):
	if current_level != null:
		current_level.queue_free()
	var full_name = "res://levels/%s.tscn" % name
	current_level = load(full_name).instantiate()
	add_child(current_level)
