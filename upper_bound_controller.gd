extends Area2D

func _ready() -> void:
	body_entered.connect(on_collision)


func on_collision(body: Node2D):
	if body.has_method("boundary_collision"):
		body.boundary_collision()
	
