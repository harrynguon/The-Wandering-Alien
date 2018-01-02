extends Node

signal anim_finished

func _ready():
	pass

func play(anim):
	$CanvasLayer.layer = 3
	$AnimationPlayer.play(anim)

func _on_AnimationPlayer_animation_finished( name ):
	emit_signal("anim_finished")
