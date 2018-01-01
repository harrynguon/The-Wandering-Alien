extends Area2D

signal end_point_reached

func _ready():
	pass

# when a player reaches the finish zone, pop up the game over window
func _on_level_endpoint_body_entered( body ):
	if body.get_name() == "Player":
		emit_signal("end_point_reached")