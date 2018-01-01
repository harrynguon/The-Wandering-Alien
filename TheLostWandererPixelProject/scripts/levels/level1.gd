extends Node2D

func _ready():
	$level_endpoint.connect("end_point_reached", self, "game_over")
	$Player.prep_animation()
	$fade_in_node/AnimationPlayer.play("fade")
	$CanvasLayer/GUI.hide()
	$CanvasLayer/GUI.set_process(false)
	
func _on_AnimationPlayer_animation_finished( name ):
	if name == "camera move":
		$AnimationPlayer/Camera2D.current = false
		$Player.finish_animation()
		$CanvasLayer/GUI.show()
		$CanvasLayer/GUI.set_process(true)

func _on_fade_in_node_anim_finished():
	$Player/Camera2D.current = false
	$AnimationPlayer/Camera2D.current = true
	$AnimationPlayer.play("camera move")
	
func game_over():
	print("congrats")
