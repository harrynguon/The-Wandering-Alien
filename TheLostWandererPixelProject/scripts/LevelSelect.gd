extends Control

var level_selected
signal back_btn_pressed

func _ready():
	level_selected = 0
	pass

func _on_Level_1_pressed():
	level_selected = 1
	$fade_out_node/black_background.centered = false
	$fade_out_node/AnimationPlayer.play("fade")
	

func _on_Back_pressed():
	emit_signal("back_btn_pressed")

func _on_fade_out_node_anim_finished():
	$fade_out_node/black_background.centered = true
	get_node("/root/global").goto_scene("res://scenes/levels/level%s.tscn" % level_selected)
