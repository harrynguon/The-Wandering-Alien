extends Area2D

var active

func _ready():
	active = true
	pass

func _on_Star_body_entered( body ):
	if active:
		get_node("/root/global").star_picked_up()
		$AnimationPlayer.play("fade_out")
		active = false

func _on_AnimationPlayer_animation_finished( name ):
	queue_free()
