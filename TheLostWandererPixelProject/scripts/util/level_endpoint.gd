extends Area2D

signal end_point_reached

func _ready():
	pass

func _on_level_endpoint_body_entered( body ):
	if body.get_name() == "Player":
		emit_signal("end_point_reached")