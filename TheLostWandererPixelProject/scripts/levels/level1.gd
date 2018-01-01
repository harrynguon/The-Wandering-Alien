extends Node2D

func _ready():
	$CanvasLayer2/Level_complete.hide()
	$level_endpoint.connect("end_point_reached", self, "game_over")
	$Player.prep_animation()
	$fade_node/fade_in_node/AnimationPlayer.play("fade")
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

# Make the player unable to move, hide the controls, and animate the
# level over popup window
func game_over():
	$Player.set_physics_process(false)
	$Player/AnimatedSprite.stop()
	$CanvasLayer/GUI.hide()
	$CanvasLayer/GUI.set_process(false)
	$fade_node/fade_in_node.visible = true
	$fade_node/fade_in_node.modulate = Color(1, 1, 1, 0.2)
	$CanvasLayer2/Level_complete.show()
	$CanvasLayer2/Level_complete/AnimationPlayer.play("window_frame_fly_down")
