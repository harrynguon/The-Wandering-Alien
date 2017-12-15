extends Node2D

func _ready():
	modulate.a = 0
	$ParallaxBackground/ParallaxLayer.modulate.a = 0
	visible = true
	$ParallaxBackground/ParallaxLayer.visible = true
	$Player.prep_animation()
	$AnimationPlayer.play("fade_in")
	pass
	
func set_invisible():
	visible = false
	$ParallaxBackground/ParallaxLayer.visible = false

func _on_AnimationPlayer_animation_finished( name ):
	if name == "camera move":
		$AnimationPlayer/Camera2D.current = false
		$Player.finish_animation()
	elif name == "fade_in":
		$AnimationPlayer/Camera2D.current = true
		$AnimationPlayer.play("camera move")
	pass # replace with function body

