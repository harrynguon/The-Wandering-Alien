extends Node2D

func _ready():
	$Player.prep_animation()
	$AnimationPlayer/Camera2D.current = true
	$AnimationPlayer.play("camera move")
	pass

func _on_AnimationPlayer_animation_finished( name ):
	$AnimationPlayer/Camera2D.current = false
	$Player.finish_animation()
	pass # replace with function body
