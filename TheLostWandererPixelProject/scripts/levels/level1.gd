extends Node2D

func _ready():
	$Player.prep_animation()
	$fade_in_node/AnimationPlayer.play("fade")
	$CanvasLayer/GUI/HBoxContainer.hide()
	$CanvasLayer/GUI/HBoxContainer.set_process(false)
	
func _on_AnimationPlayer_animation_finished( name ):
	if name == "camera move":
		$AnimationPlayer/Camera2D.current = false
		$Player.finish_animation()
		$CanvasLayer/GUI/HBoxContainer.show()
		$CanvasLayer/GUI/HBoxContainer.set_process(true)

func _on_fade_in_node_anim_finished():
	$Player/Camera2D.current = false
	$AnimationPlayer/Camera2D.current = true
	$AnimationPlayer.play("camera move")
