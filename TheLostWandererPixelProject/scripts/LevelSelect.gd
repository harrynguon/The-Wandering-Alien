extends Control

func _ready():
	pass

func _on_Level_1_pressed():
	$AnimationPlayer.set_level(1)
	$AnimationPlayer.play("fade_out")
	

func _on_Back_pressed():
	var test = get_node("/root/global").goto_scene("res://scenes/MainMenu.tscn")

func _on_AnimationPlayer_animation_finished( name ):
	get_node("/root/global").goto_scene("res://scenes/levels/level%s.tscn" % $AnimationPlayer.level_pressed)
