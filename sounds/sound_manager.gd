extends Node2D

const MUSIC_BUS_INDEX = 1
const SFX_BUS_INDEX = 2

func _ready() -> void:
	SignalBus.set_music_is_on.connect(_on_set_music_is_on)
	SignalBus.set_sfx_is_on.connect(_on_set_sfx_is_on)


func _on_set_music_is_on(is_on: bool):
	print("Setting music to on: %s" % is_on)
	AudioServer.set_bus_mute(MUSIC_BUS_INDEX, !is_on)

func _on_set_sfx_is_on(is_on: bool):
	print("Setting sfx to on: %s" % is_on)
	AudioServer.set_bus_mute(SFX_BUS_INDEX, !is_on)
