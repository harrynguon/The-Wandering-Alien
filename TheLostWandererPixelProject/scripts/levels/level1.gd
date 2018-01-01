extends Node2D

func _ready():
	$level_endpoint.connect("end_point_reached", self, "game_over")
	$Player.prep_animation()
	# create the fade instance only when needed to minimise visual editor clutter
	var fade_in_instance = load("res://scenes/util/fade_in_node.tscn").instance()
	fade_in_instance.connect("fade_finished", self, "on_fade_in_node_anim_finished")
	$fade_node.add_child(fade_in_instance)
	$fade_node/fade_in_node/AnimationPlayer.play("fade")
	# hide gui
	$CanvasLayer/GUI.hide()
	$CanvasLayer/GUI.set_process(false)
	
func _on_AnimationPlayer_animation_finished( name ):
	if name == "camera move":
		$AnimationPlayer/Camera2D.current = false
		$Player.finish_animation()
		$CanvasLayer/GUI.show()
		$CanvasLayer/GUI.set_process(true)

func on_fade_in_node_anim_finished():
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
	# create an instance of the level complete scene when needed, instead of having
	# to add it to the editor manually hiding it when not in use
	$CanvasLayer2.add_child(load("res://scenes/popups/Level_complete.tscn").instance())
	$CanvasLayer2/Level_complete.set_number_of_stars($Player.no_stars)
	$CanvasLayer2/Level_complete.show()
	$CanvasLayer2/Level_complete/AnimationPlayer.play("window_frame_fly_down")
