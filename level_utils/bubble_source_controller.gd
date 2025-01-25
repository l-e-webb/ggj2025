extends Node

func _ready() -> void:
	SignalBus.bubble_type_selected.connect(spotlight_selected_bubble_source)
	$Gum.self_modulate = Color(0.5, 0.5, 0.5, 1)
	$Elevator.self_modulate = Color(0.5, 0.5, 0.5, 1)
	
func spotlight_selected_bubble_source(index: int):
	print("spotlight: " + str(index))
	if index == 1:
		$Plain.self_modulate = Color(0.5, 0.5, 0.5, 1)
		$Gum.self_modulate = Color(1, 1, 1, 1)
		$Elevator.self_modulate = Color(0.5, 0.5, 0.5, 1)
	else:
		$Plain.self_modulate = Color(1, 1, 1, 1)
		$Gum.self_modulate = Color(0.5, 0.5, 0.5, 1)
		$Elevator.self_modulate = Color(0.5, 0.5, 0.5, 1)
	
