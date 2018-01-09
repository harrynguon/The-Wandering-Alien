extends Node2D

func _ready():
	$Elements/Play.connect("pressed", self, "play_btn_pressed")
	$LevelSelectNode/LevelSelect/Back_Button.connect("pressed", self, "back_btn_pressed")
	connect_levels()

func connect_levels():
	$LevelSelectNode/LevelSelect/Border/Levels/level1.connect("pressed", self, "level_1_pressed")
	
func play_btn_pressed():
	$AnimationPlayer.play("move_right")

func back_btn_pressed():
	$AnimationPlayer.play("move_left")
	
func level_1_pressed():
	var fade_out_instance = load("res://scripts/util/fade_out_node.gd").instance()
	fade_out_instance.fade_out()
