extends Node2D

var dont_play_anim = false

func _ready():
	$AnimationPlayer.connect("animation_finished", self, "_on_AnimationPlayer_animation_finished")
	$level_endpoint.connect("end_point_reached", self, "game_over")
	$Player.prep_animation()
	# hide gui
	$CanvasLayer/GUI.hide()
	$CanvasLayer/GUI.set_process(false)
	# create the fade instance only when needed to minimise visual editor clutter
	var fade_in_instance = load("res://scenes/util/fade_in_node.tscn").instance()
	fade_in_instance.connect("fade_finished", self, "on_fade_in_node_anim_finished")
	add_child(fade_in_instance)
	$fade_in_node.play("fade")
	
func set_anim(result):
	dont_play_anim = result
	
func _on_AnimationPlayer_animation_finished( name ):
	if name == "cutscene":
		$AnimationPlayer/CameraMovementCutscene.current = false
		$Player.finish_animation()
		$CanvasLayer/GUI.show()
		$CanvasLayer/GUI.set_process(true)

func on_fade_in_node_anim_finished():
	# dont play the camera move animation and just go straight into
	# gameplay
	if dont_play_anim:
		_on_AnimationPlayer_animation_finished("cutscene")
	else:
#		_on_AnimationPlayer_animation_finished("cutscene")
		$Player/Camera2D.current = false
		$AnimationPlayer/CameraMovementCutscene.current = true
		$AnimationPlayer.play("cutscene")

# Make the player unable to move, hide the controls, and animate the
# level over popup window
func game_over():

	$Player.set_physics_process(false)
	$Player/AnimatedSprite.stop()
	$CanvasLayer/GUI.hide()
	$CanvasLayer/GUI.set_process(false)
	$fade_in_node/CanvasLayer.layer = 1 # do not overlap on top of the whole screen
	$fade_in_node/CanvasLayer/black_background.visible = true
	$fade_in_node/CanvasLayer/black_background.modulate = Color(1, 1, 1, 0.2)
	# create an instance of the level complete scene when needed, instead of having
	# to add it to the editor manually hiding it when not in use
	$Popup.add_child(load("res://scenes/popups/Level_complete.tscn").instance())
	$Popup/Level_complete.set_number_of_stars($Player.no_stars)
	$Popup/Level_complete.show()
	$Popup/Level_complete/AnimationPlayer.play("window_frame_fly_down")
