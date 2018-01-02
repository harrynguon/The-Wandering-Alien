extends Node

signal fade_finished

func _ready():
	pass
	
func play(anim):
	$AnimationPlayer.play(anim)

func _on_AnimationPlayer_animation_finished( name ):
	emit_signal("fade_finished")
