extends Node2D

@export var level_order: Array = []

var eve_bg = preload("res://level_utils/eveningbackground.png")
var night_bg = preload("res://level_utils/nightbackground.png")

var current_level = null
var current_level_name: String
var awaiting_level_change = false

func _ready():
	SignalBus.load_level.connect(load_level)
	SignalBus.player_win.connect(_on_win)
	if !level_order.is_empty():
		SignalBus.load_level.emit(level_order[0])
	

func load_level(name: String):
	if current_level != null:
		current_level.queue_free()
	current_level_name = name
	var full_name = "res://levels/%s.tscn" % name
	current_level = load(full_name).instantiate()
	add_child(current_level)
	check_update_background()

func _on_win():
	if awaiting_level_change:
		return
	
	awaiting_level_change = true
	await get_tree().create_timer(1).timeout
	var current_level_index = level_order.find(current_level_name)
	if current_level_index == -1:
		return
	
	current_level_index += 1
	current_level_index = current_level_index % level_order.size()
	if current_level_index < level_order.size():
		SignalBus.load_level.emit(level_order[current_level_index])
	awaiting_level_change = false

func check_update_background():
	var current_level_index = level_order.find(current_level_name)
	if current_level_index == -1:
		return
	
	if current_level_index > level_order.size() / 2:
		$BackgroundImage.texture = night_bg
	else:
		$BackgroundImage.texture = eve_bg
