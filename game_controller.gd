extends Node2D

@export var level_order: Array = []

var eve_bg = preload("res://level_utils/eveningbackground.png")
var night_bg = preload("res://level_utils/nightbackground.png")

var current_level = null
var current_level_index: int = 0
var awaiting_level_change = false

func _ready():
	SignalBus.load_level.connect(load_level)
	SignalBus.player_win.connect(_on_win)
	SignalBus.pause_game.connect(_on_pause)
	SignalBus.unpause_game.connect(_on_unpause)
	SignalBus.player_die.connect(_on_player_die)
	if !level_order.is_empty():
		SignalBus.load_level.emit(0)
	

func load_level(index: int):
	if current_level != null:
		current_level.queue_free()
	
	current_level_index = index
	var name = level_order[index]
	var full_name = "res://levels/%s.tscn" % name
	current_level = load(full_name).instantiate()
	$GameContents.add_child(current_level)
	check_update_background()
	spawn_player()

func check_update_background():
	if current_level_index > level_order.size() / 2:
		$GameContents/BackgroundImage.texture = night_bg
	else:
		$GameContents/BackgroundImage.texture = eve_bg

func spawn_player():
	var player = load("res://SealPlayer/Player.tscn").instantiate()
	$GameContents.add_child(player)
	SignalBus.send_player_to_start.emit()

func _on_player_die():
	SignalBus.despawn_player.emit()
	spawn_player()

func _on_win():
	if awaiting_level_change:
		return
	
	awaiting_level_change = true
	await get_tree().create_timer(2.2).timeout
	
	SignalBus.despawn_player.emit()
	
	current_level_index += 1
	if current_level_index >= level_order.size():
		get_tree().change_scene_to_file("res://Ending.tscn")
		return
	
	if current_level_index < level_order.size():
		SignalBus.load_level.emit(current_level_index)
	awaiting_level_change = false



func _on_pause():
	get_tree().paused = true
	$PauseMenu.visible = true

func _on_unpause():
	get_tree().paused = false
	$PauseMenu.visible = false

func _input(event: InputEvent) -> void:
	if !awaiting_level_change and event.is_action_pressed("pause"):
		if get_tree().paused:
			SignalBus.unpause_game.emit()
		else:
			SignalBus.pause_game.emit()
